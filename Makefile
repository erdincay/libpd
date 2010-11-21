PD_FILES = \
	pure-data/src/d_arithmetic.c pure-data/src/d_array.c pure-data/src/d_ctl.c \
	pure-data/src/d_dac.c pure-data/src/d_delay.c pure-data/src/d_fft.c \
	pure-data/src/d_fft_mayer.c pure-data/src/d_fftroutine.c \
	pure-data/src/d_filter.c pure-data/src/d_global.c pure-data/src/d_math.c \
	pure-data/src/d_misc.c pure-data/src/d_osc.c pure-data/src/d_resample.c \
	pure-data/src/d_soundfile.c pure-data/src/d_ugen.c \
	pure-data/src/g_all_guis.c pure-data/src/g_array.c pure-data/src/g_bang.c \
	pure-data/src/g_canvas.c pure-data/src/g_editor.c pure-data/src/g_graph.c \
	pure-data/src/g_guiconnect.c pure-data/src/g_hdial.c \
	pure-data/src/g_hslider.c pure-data/src/g_io.c pure-data/src/g_mycanvas.c \
	pure-data/src/g_numbox.c pure-data/src/g_readwrite.c \
	pure-data/src/g_rtext.c pure-data/src/g_scalar.c pure-data/src/g_template.c \
	pure-data/src/g_text.c pure-data/src/g_toggle.c pure-data/src/g_traversal.c \
	pure-data/src/g_vdial.c pure-data/src/g_vslider.c pure-data/src/g_vumeter.c \
	pure-data/src/m_atom.c pure-data/src/m_binbuf.c pure-data/src/m_class.c \
	pure-data/src/m_conf.c pure-data/src/m_glob.c pure-data/src/m_memory.c \
	pure-data/src/m_obj.c pure-data/src/m_pd.c pure-data/src/m_sched.c \
	pure-data/src/s_audio.c pure-data/src/s_audio_dummy.c \
	pure-data/src/s_entry.c pure-data/src/s_file.c pure-data/src/s_inter.c \
	pure-data/src/s_loader.c pure-data/src/s_main.c pure-data/src/s_midi.c \
	pure-data/src/s_midi_dummy.c pure-data/src/s_path.c pure-data/src/s_print.c \
	pure-data/src/s_utf8.c pure-data/src/x_acoustics.c \
	pure-data/src/x_arithmetic.c pure-data/src/x_connective.c \
	pure-data/src/x_gui.c pure-data/src/x_interface.c pure-data/src/x_list.c \
	pure-data/src/x_midi.c pure-data/src/x_misc.c pure-data/src/x_net.c \
	pure-data/src/x_qlist.c pure-data/src/x_time.c \
	libpd_wrapper/x_libpdreceive.c libpd_wrapper/z_libpd.c
JNI_FILES = libpd_wrapper/z_jni.c
LIBPD = libpd.so
PDJAVA = libpdnative.so

CFLAGS = -DPD -DHAVE_UNISTD_H -DHAVE_LIBDL -DUSEAPI_DUMMY \
			-Wno-int-to-pointer-cast -Wno-pointer-to-int-cast \
			-I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux \
			-I./pure-data/src -I./libpd_wrapper

.PHONY: all clean clobber

all: $(LIBPD) $(PDJAVA)

$(LIBPD): ${PD_FILES:.c=.o}
	gcc -shared -ldl -lm -lpthread -o $(LIBPD) $^

$(PDJAVA): ${PD_FILES:.c=.o} ${JNI_FILES:.c=.o}
	gcc -shared -ldl -lm -lpthread -o $(PDJAVA) $^

clean:
	rm -f ${PD_FILES:.c=.o} ${JNI_FILES:.c=.o}

clobber: clean
	rm -f $(LIBPD) $(PDJAVA)

