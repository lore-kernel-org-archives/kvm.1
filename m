Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8555733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406244; cv=none; b=LoYHn8cxM2dopDs5bdAuJvskVQD4NXLxL7uZmkb+saPBK6OP9Pt0Etxyq5WrgUmEZI55GxIwoR8+vWTVd1y+qJtdVZdFQmzBZk6XOGjUMkULMxYQD3NzLYmba5K+o/vI2/EWDmuadPY30n7tgs2nkb+lO7l9Zzko8MkTkOmWjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406244; c=relaxed/simple;
	bh=Ajyl4vuW8c3i0gdCGVztW06XoMio3RxRbzsZp+qyAdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAGfH85NIj1Wp5y09bDEFfLby20TBTQO8HWKsekCmEXITOdlWXvVIkgNOCRAu1hilgA2CMbzp3rREnffIF97EbK8NYcsCVtEAkh0NtXlFuP+MZaZRPdtHMrXH9vBriijXjjYiCh9Y/re9QkL4XwniA7CsbBDGsAFJ497ZTJkfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI/7ukWQ; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI/7ukWQ"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso869669c88.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406242; x=1791011042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKOEnoJQ/ccsACw/aTGJU/jJy11AbBBe19tBMAh69fU=;
        b=CI/7ukWQi9xtcJQCSaix7i9R6douOsDhceXx5vvYS39Xn7mktjpUiqf00RBdsINWoY
         rfneKFlRPqGN7ZctK0pIaDRuMOxOFQ4TNvBYv+YgR00Y1d/QIgmrotwcltmkIMPu6CFo
         ixJVckPkX0qwT4GfF0YRyVV8XthKLq7k/AADpPsiAXQ8GKVwxySrq0PmhKcMVCA8L4hK
         JJSLYgJffjNZ7PwHJToa7DiADRGhex7ta3+bslEF/RPvVaEYyyZFIG6wPuo4RhBtv5Oe
         ncSU3hcF+D2jAwh48VEFYHTuffnanIpzHtJO7jMzgCYSjDhjkgiAAqxD6uTnq+xP4aOK
         D8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406242; x=1791011042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKOEnoJQ/ccsACw/aTGJU/jJy11AbBBe19tBMAh69fU=;
        b=zi4U85Ugrf2+rygQOvxJCGb+mt34+r/6CCRymqNsFFxfZs6t5eiz2CeBuWnEVtw6Rm
         m60lBFke5f0XvtUAW/fZIeEWpC22J17DYrWIJxnEuAWi3twyCkoA8fwOzRi2m0dpDerB
         kgjNwACBnorWN8fDoljyW7kGLnxxZE+JP8NbacmaHcDMamVl/rnpKPsViPgTBCGQLFUF
         dQ5rsjCqneOG/h5AsHhFIwCakRtG2BVAs/W6P5bzrLxfhGvbCaM3cJot769ueuH9OjFy
         VkiYIH6mbjJx99c3DjRd9Dl6aTKSXco4AUEGk+bvP3U/Mb8XdDk62TQCq8leI7hTW+iu
         8H9g==
X-Forwarded-Encrypted: i=1; AKwUvByVLNiIzkxsEXnAHevwwYS4qwA/NBlAVCrBvdCAKw+e3V3KOvlNhU4d0wrF3QI+qKjvyQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnIXORq76SIgJo37/r7s+zKdCh3bV8zV89E0j+9/C9e8bGKelP
	iKcWKZX1nrsD1Dxi3kGIvm8/z+1TPuxwrQ74uk85pqKVZn5lZ7eTGqF1
X-Gm-Gg: AYBFou2VZ7ywYTaVWvK1N0/so2E7tNWAXcvkeTPreWytHXcICM6osgVQZYFt5ukhXe8
	L7uJlFV6fk+x0usp3uoDBbT4yAANtiArSMW1vlWD13CH//JHjLmCzO3XlfpDiGAkUjEtR4HbUFw
	Wx8qAxiaWSlvAkPulCWQsKmkcYAxUSMD715ndCY9oBlsI1G0xkPG442+ZBGxrL8q5aB1Dw/Rtwo
	ORjlL/FUqCjIj3IcoIoJb67bjzq7YEsgXWrpJmVsUw7YIVyaIqEJ3DPQHr0aANA5cAKdzskgXVp
	fNb4O5ej2lal8cGsEUBkkPBEPRGjOvInzl+qxA8Uk0yCLhv4zgzU5wtEzWMEcRqmf6XNbNjqeGZ
	DrFHoWLgO2hmUKzfoU6xccB3xIl46KZ5UE6pF7ajKS5e6j8dukwpV3h2ZqouPJt3ghHQ4hjOtEp
	SesyqsGtKvgtpUmhxC+R5mT9YDGbTun0DnqjhAJKs2eT2xo4AnsFNHllkSPYx6UJ1ANhpBZYHH7
	m0kt3Q6UiUV082EFPcH1SI5nnRiJz8=
X-Received: by 2002:a05:7022:f502:b0:141:aa71:6f4c with SMTP id a92af1059eb24-146ce1a9aacmr2071858c88.10.1790406241683;
        Sat, 26 Sep 2026 00:04:01 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 45/55] vl: parse arch: machine types on combined qemu-system
Date: Sat, 26 Sep 2026 15:00:44 +0800
Message-ID: <20260926070057.1234-46-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The combined binary takes arch:name on -M/-machine and in a
[machine] type from the default config file or -readconfig, and
selects that target before QOM init. The default file is read
first. -nouserconfig skips only that file. select_machine()
matches the machine in the selected target.
qemu_read_config_file_cb() supplies the callback for that early
pass. qemu-options.hx documents arch:name and arch:help.

- A later bare name keeps the last arch prefix
- Last -M wins for help
- Plain -M help lists every target; arch:help lists one target
- qemu-system-<arch> still prints machine help after early options

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/config-file.h |   2 +
 qemu-options.hx            |  11 +-
 system/vl.c                | 294 ++++++++++++++++++++++++++++++++++---
 util/qemu-config.c         |  10 +-
 4 files changed, 291 insertions(+), 26 deletions(-)

diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index 51b310fa3b4..f733b0e9769 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -22,6 +22,8 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname,
 void qemu_config_do_parse(const char *group, QDict *qdict, void *opaque, Error **errp);
 
 int qemu_read_config_file(const char *filename, QEMUConfigCB *f, Error **errp);
+int qemu_read_config_file_cb(const char *filename, QEMUConfigCB *f,
+                             void *opaque, Error **errp);
 
 /* Parse QDict options as a replacement for a config file (allowing multiple
    enumerated (0..(n-1)) configuration "sections") */
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b0..32be1ceeda2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -27,6 +27,8 @@ ERST
 DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop=value[,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
+    "                use arch:name (e.g. aarch64:virt) on the combined binary\n"
+    "                '-machine help' lists all targets; use arch:help for one\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
     "                supported accelerators are kvm, xen, hvf, nitro, nvmm, whpx, mshv or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
@@ -53,7 +55,14 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
     Select the emulated machine by name. Use ``-machine help`` to list
-    available machines.
+    available machines. On a single-target binary this lists that
+    target. On the combined qemu-system binary, ``-machine help``
+    lists every target; pass ``arch:name`` (for example
+    ``aarch64:virt``) to select one, or ``arch:help`` (for example
+    ``aarch64:help``) to list that target only. A ``[machine]``
+    ``type`` in the default config file or ``-readconfig`` uses the
+    same form. The default file is read first. A later bare name
+    keeps the last arch prefix.
 
     For architectures which aim to support live migration compatibility
     across releases, each release will introduce a new versioned machine
diff --git a/system/vl.c b/system/vl.c
index 7f1381d84ff..1bdd5b2da05 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,8 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-select.h"
+#include "qemu/target-info-def.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -842,6 +844,12 @@ static bool usb_parse(const char *cmdline, Error **errp)
 /***********************************************************/
 /* machine registration */
 
+/* Same grouping as -M help: each machine must have is_available. */
+static bool machine_class_in_target(MachineClass *mc, const TargetInfo *ti)
+{
+    return object_class_get_is_available(OBJECT_CLASS(mc))(ti);
+}
+
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
@@ -850,6 +858,9 @@ static MachineClass *find_machine(const char *name, GSList *machines)
         MachineClass *mc = el->data;
 
         if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            if (!machine_class_in_target(mc, target_info())) {
+                continue;
+            }
             return mc;
         }
     }
@@ -866,6 +877,9 @@ static MachineClass *find_default_machine(GSList *machines)
         MachineClass *mc = el->data;
 
         if (mc->is_default) {
+            if (!machine_class_in_target(mc, target_info())) {
+                continue;
+            }
             assert(default_machineclass == NULL && "Multiple default machines");
             default_machineclass = mc;
         }
@@ -874,6 +888,106 @@ static MachineClass *find_default_machine(GSList *machines)
     return default_machineclass;
 }
 
+/*
+ * Split "aarch64:virt". "aarch64:" binds arch and leaves an empty name.
+ * A leading colon is not a prefix. *machine_name always takes the latest
+ * parsed name; NULL type leaves it unchanged. keep_target leaves
+ * *machine_target unchanged when the new type has no prefix.
+ */
+static void machine_type_parse_target(const char *type,
+                                      char **machine_name,
+                                      char **machine_target,
+                                      bool keep_target)
+{
+    const char *colon = NULL;
+    const char *parsed_name = NULL;
+    const char *parsed_target = NULL;
+
+    if (type) {
+        colon = strchr(type, ':');
+        if (!colon || colon == type) {
+            parsed_name = type;
+        } else {
+            parsed_target = type;
+            parsed_name = colon + 1;
+        }
+    }
+
+    if (parsed_name) {
+        g_free(*machine_name);
+        *machine_name = g_strdup(parsed_name);
+    }
+    if (parsed_target || !keep_target) {
+        g_free(*machine_target);
+        *machine_target = parsed_target ?
+            g_strndup(parsed_target, colon - parsed_target) : NULL;
+    }
+}
+
+typedef struct MachineTypeOpt {
+    char *type;
+    char *name;
+    char *target;
+    bool help;
+} MachineTypeOpt;
+
+static void machine_type_opt_clear(MachineTypeOpt *opt)
+{
+    g_free(opt->type);
+    g_free(opt->name);
+    g_free(opt->target);
+    opt->type = NULL;
+    opt->name = NULL;
+    opt->target = NULL;
+}
+
+G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(MachineTypeOpt, machine_type_opt_clear)
+
+/* A bare name keeps the previous arch prefix. */
+static void machine_type_opt_set(MachineTypeOpt *opt, const char *type,
+                                 bool help)
+{
+    if (!type && !help) {
+        return;
+    }
+    if (type) {
+        g_free(opt->type);
+        opt->type = g_strdup(type);
+        machine_type_parse_target(opt->type, &opt->name, &opt->target, true);
+    }
+    opt->help = help || (type && opt->name && is_help_option(opt->name));
+}
+
+static void qemu_config_set_machine_type(const char *group, QDict *qdict,
+                                         void *opaque, Error **errp)
+{
+    MachineTypeOpt *opt = opaque;
+
+    (void)errp;
+    if (strcmp(group, "machine") != 0) {
+        return;
+    }
+    machine_type_opt_set(opt, qdict_get_try_str(qdict, "type"), false);
+}
+
+static void machine_type_config_file(const char *filename, bool optional,
+                                     MachineTypeOpt *opt)
+{
+    Error *err = NULL;
+    int ret;
+
+    ret = qemu_read_config_file_cb(filename, qemu_config_set_machine_type,
+                                   opt, &err);
+    if (ret < 0) {
+        if (optional && ret == -ENOENT) {
+            error_free(err);
+            return;
+        }
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 static void version(void)
 {
     printf("QEMU emulator version " QEMU_FULL_VERSION "\n"
@@ -1563,25 +1677,31 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
                   object_class_get_name(OBJECT_CLASS(mc1)));
 }
 
-static void machine_help_func(const QDict *qdict)
+static void machine_help_print_target(GSList *machines, const TargetInfo *ti,
+                                      const char *machine_target)
 {
-    g_autoptr(GSList) machines = NULL;
+    bool printed = false;
     GSList *el;
-    const char *type = qdict_get_try_str(qdict, "type");
+    bool combined = target_combined_binary();
+    bool print_header = combined && !machine_target;
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
-    if (type) {
-        ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
-        if (machine_class) {
-            type_print_class_properties(object_class_get_name(machine_class));
-            return;
-        }
+    if (!combined) {
+        g_assert(ti == target_info());
+    } else if (machine_target && ti != target_info()) {
+        /* -M arch:help: skip every target except the selected one. */
+        return;
     }
 
-    printf("Supported machines are:\n");
-    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+
+        if (!machine_class_in_target(mc, ti)) {
+            continue;
+        }
+        if (print_header && !printed) {
+            printf("%s:\n", ti->target_name);
+            printed = true;
+        }
         if (mc->alias) {
             printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
@@ -1590,6 +1710,54 @@ static void machine_help_func(const QDict *qdict)
                mc->deprecation_reason ? " (deprecated)" : "",
                object_class_is_secure(OBJECT_CLASS(mc)) ? " (secure)" : "");
     }
+
+    if (print_header && printed) {
+        printf("\n");
+    }
+}
+
+static void machine_help_func(const char *type,
+                              const char *machine_name,
+                              const char *machine_target)
+{
+    g_autoptr(GSList) machines = NULL;
+    MachineClass *mc = NULL;
+    TargetInfoNode *node;
+
+    machines = object_class_get_list(TYPE_MACHINE, false);
+
+    if (machine_name && *machine_name && !is_help_option(machine_name)) {
+        mc = find_machine(machine_name, machines);
+        if (mc) {
+            type_print_class_properties(object_class_get_name(OBJECT_CLASS(mc)));
+            return;
+        }
+        if (target_none()) {
+            error_report("machine type \"%s\" needs an arch: prefix",
+                         machine_name);
+            exit(1);
+        }
+        error_report("unsupported machine type: \"%s\"", type);
+        exit(1);
+    }
+
+    if (type && (!machine_name || !*machine_name)) {
+        if (!target_none()) {
+            mc = find_default_machine(machines);
+            if (!mc) {
+                error_report("No machine specified, and there is no default");
+                exit(1);
+            }
+            type_print_class_properties(object_class_get_name(OBJECT_CLASS(mc)));
+            return;
+        }
+    }
+
+    printf("Supported machines are:\n");
+    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
+    QLIST_FOREACH(node, target_info_list(), next) {
+        machine_help_print_target(machines, node->info, machine_target);
+    }
 }
 
 static void
@@ -1684,18 +1852,58 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
     const char *machine_type = qdict_get_try_str(qdict, "type");
     g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class = NULL;
+    g_autofree char *machine_target = NULL;
+    g_autofree char *machine_name = NULL;
 
     if (machine_type) {
-        machine_class = find_machine(machine_type, machines);
+        machine_type_parse_target(machine_type, &machine_name, &machine_target, false);
+        if (machine_target && strcmp(target_name(), machine_target) != 0) {
+            error_setg(errp, "machine type \"%s\" is not available "
+                       "for target %s", machine_type, target_name());
+            error_append_hint(errp,
+                              "Use -machine help to list supported "
+                              "machines\n");
+            return NULL;
+        }
+    }
+
+    if (machine_name && *machine_name) {
+        machine_class = find_machine(machine_name, machines);
         if (!machine_class) {
-            error_setg(errp, "unsupported machine type: \"%s\"", machine_type);
+            if (machine_target && target_none()) {
+                error_setg(errp, "machine type \"%s\" is not available "
+                           "for target %s", machine_type, target_name());
+            } else if (target_none()) {
+                error_setg(errp,
+                           "machine type \"%s\" needs an arch: prefix",
+                           machine_name);
+                error_append_hint(errp,
+                                  "Use -M arch:name (e.g. aarch64:virt) "
+                                  "or -machine help\n");
+                return NULL;
+            } else {
+                error_setg(errp, "unsupported machine type: \"%s\"",
+                           machine_type);
+            }
         }
-        qdict_del(qdict, "type");
-    } else {
+    } else if (!target_none()) {
         machine_class = find_default_machine(machines);
         if (!machine_class) {
             error_setg(errp, "No machine specified, and there is no default");
         }
+    } else {
+        machine_class = find_machine("none", machines);
+        if (!machine_class) {
+            error_setg(errp, "No machine specified");
+            error_append_hint(errp,
+                              "Use -M arch:name (e.g. aarch64:virt) or "
+                              "-machine help\n");
+            return NULL;
+        }
+    }
+
+    if (machine_type) {
+        qdict_del(qdict, "type");
     }
 
     if (!machine_class) {
@@ -2872,6 +3080,9 @@ void qemu_init(int argc, char **argv)
     const char *optarg;
     MachineClass *machine_class;
     bool userconfig = true;
+    int parse_opt_pass = 0;
+    /* Combined: NULL target selects NONE. Single-target stub ignores this. */
+    g_auto(MachineTypeOpt) machine_opt = { };
     FILE *vmstate_dump_file = NULL;
 
     qemu_add_opts(&qemu_drive_opts);
@@ -2911,9 +3122,23 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
-    /* first pass of option parsing */
+    /*
+     * Pass 0 records -nouserconfig. Pass 1 parses -M and -readconfig
+     * into machine_opt. The loop ends only after pass 1.
+     */
     optind = 1;
-    while (optind < argc) {
+    for (parse_opt_pass = 0; parse_opt_pass < 2;) {
+        if (optind >= argc) {
+            if (parse_opt_pass == 0 && userconfig) {
+                g_autofree char *file =
+                    get_relocated_path(CONFIG_QEMU_CONFDIR "/qemu.conf");
+
+                machine_type_config_file(file, true, &machine_opt);
+            }
+            parse_opt_pass += 1;
+            optind = 1;
+            continue;
+        }
         if (argv[optind][0] != '-') {
             /* disk image */
             optind++;
@@ -2923,7 +3148,27 @@ void qemu_init(int argc, char **argv)
             popt = lookup_opt(argc, argv, &optarg, &optind);
             switch (popt->index) {
             case QEMU_OPTION_nouserconfig:
-                userconfig = false;
+                if (parse_opt_pass == 0) {
+                    userconfig = false;
+                }
+                break;
+            case QEMU_OPTION_M:
+            case QEMU_OPTION_machine:
+                if (parse_opt_pass == 1) {
+                    bool help = false;
+                    g_autoptr(QDict) dict = qdict_new();
+                    const char *type;
+
+                    keyval_parse_into(dict, optarg, "type", &help,
+                                      &error_fatal);
+                    type = qdict_get_try_str(dict, "type");
+                    machine_type_opt_set(&machine_opt, type, help);
+                }
+                break;
+            case QEMU_OPTION_readconfig:
+                if (parse_opt_pass == 1) {
+                    machine_type_config_file(optarg, false, &machine_opt);
+                }
                 break;
             }
         }
@@ -2931,6 +3176,8 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
+    target_info_select_by_name(machine_opt.target, &error_fatal);
+
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
@@ -3435,10 +3682,6 @@ void qemu_init(int argc, char **argv)
                     bool help;
 
                     keyval_parse_into(machine_opts_dict, optarg, "type", &help, &error_fatal);
-                    if (help) {
-                        machine_help_func(machine_opts_dict);
-                        exit(EXIT_SUCCESS);
-                    }
                     break;
                 }
             case QEMU_OPTION_accel:
@@ -3770,6 +4013,11 @@ void qemu_init(int argc, char **argv)
     qemu_process_early_options();
 
     qemu_process_help_options();
+    if (machine_opt.help) {
+        machine_help_func(machine_opt.type, machine_opt.name,
+                          machine_opt.target);
+        exit(EXIT_SUCCESS);
+    }
     qemu_maybe_daemonize(pid_file);
 
     /*
diff --git a/util/qemu-config.c b/util/qemu-config.c
index d1fc49c507d..f0ef711450e 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -183,7 +183,8 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname, Error *
     return qemu_config_foreach(fp, qemu_config_do_parse, lists, fname, errp);
 }
 
-int qemu_read_config_file(const char *filename, QEMUConfigCB *cb, Error **errp)
+int qemu_read_config_file_cb(const char *filename, QEMUConfigCB *cb,
+                             void *opaque, Error **errp)
 {
     FILE *f = fopen(filename, "r");
     int ret;
@@ -193,11 +194,16 @@ int qemu_read_config_file(const char *filename, QEMUConfigCB *cb, Error **errp)
         return -errno;
     }
 
-    ret = qemu_config_foreach(f, cb, vm_config_groups, filename, errp);
+    ret = qemu_config_foreach(f, cb, opaque, filename, errp);
     fclose(f);
     return ret;
 }
 
+int qemu_read_config_file(const char *filename, QEMUConfigCB *cb, Error **errp)
+{
+    return qemu_read_config_file_cb(filename, cb, vm_config_groups, errp);
+}
+
 static bool config_parse_qdict_section(QDict *options, QemuOptsList *opts,
                                        Error **errp)
 {
-- 
2.52.0.windows.1

