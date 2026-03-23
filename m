Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487583B9D9F
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274396; cv=none; b=etk05wBbNR/hISHTZ1dQ5R9EVN2TFY3r6r/jmFDn4lPm4z9k4Gi6IgBP4se/4XfJw94lcZdFwQtRFBmlcc/MI7eA9jlBCA/osLSShTzPUM8t75pCb5zSsYVWxJ+DBHlerP9BgGfxFmsgiNGbUHPD4/mpuWIL2u/HUoWSaYzFU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274396; c=relaxed/simple;
	bh=L62qlWp3v1adwRedP//iNPVP6brfPemlKTSWzqRCVCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CyE8CQ8GgP7hyr63VR+f3Yx8zwgLOksCAP0Q6lsKZjGCCUmLVVFQLWojPcW9IJZfHhO3rfXjP7Dyav9ufXCKLrDJoonT+KfBm7FEnMjgk8uipynCfTZU7GAqX2GZDf0fdHpsR+8ErZG5+ywFOsmN5aK5waWDJLlB5koC5HGT+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UVeLNgdI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UVeLNgdI"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F30720B6F1B;
	Mon, 23 Mar 2026 06:59:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F30720B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274395;
	bh=+GcfDGF+p4TwuNzdDU1vHppWDYVvy/FB9/c/HXYoevs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVeLNgdI5nYWCu1OyAzf3VaXpB1gaFTPxadDDb6zHvYkUhmfNatrjByuo91FHcEXi
	 AVJCN2Zt+lbprqjSuAah2EzDGjyvaOGFbM22H3Mt6XYwhgXiRwJB8tNALufhPHeiY2
	 unvfwFRqfmC6PGyPiibJHBt4ed0rqPMOcSd2D39s=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 26/32] accel/mshv: migrate REFERENCE_TIME
Date: Mon, 23 Mar 2026 14:58:06 +0100
Message-Id: <20260323135812.383509-27-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a partition-wide state that we use a dedicated handler for. It
is stored as-is in the "mshv" savevm_live field. We might have to extend
this later if we have more partition-wide state to roundtrip.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 70 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 22e838ede6..3927a82925 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -85,13 +85,81 @@ static int set_time_freeze(int vm_fd, int freeze)
     return 0;
 }
 
+static int get_reference_time(int vm_fd, uint64_t *ref_time)
+{
+    int ret;
+    struct hv_input_get_partition_property in = {0};
+    struct hv_output_get_partition_property out = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+
+    args.code = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+    args.out_sz = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to get reference time");
+        return -1;
+    }
+
+    *ref_time = out.property_value;
+    return 0;
+}
+
 static void mshv_save_state(QEMUFile *f, void *opaque)
 {
-    return;
+    MshvState *s = opaque;
+    uint64_t ref_time;
+    int ret;
+
+    ret = get_reference_time(s->vm, &ref_time);
+    if (ret < 0) {
+        error_report("Failed to get reference time for migration");
+        abort();
+    }
+
+    qemu_put_be64(f, ref_time);
+}
+
+static int set_reference_time(int vm_fd, uint64_t ref_time)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+    in.property_value = ref_time;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set reference time");
+        return -1;
+    }
+
+    return 0;
 }
 
 static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)
 {
+    MshvState *s = opaque;
+    uint64_t ref_time;
+    int ret;
+
+    ref_time = qemu_get_be64(f);
+
+    ret = set_reference_time(s->vm, ref_time);
+    if (ret < 0) {
+        error_report("Failed to set reference time after migration");
+        return -1;
+    }
     return 0;
 }
 
-- 
2.34.1

