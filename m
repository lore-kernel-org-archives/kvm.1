Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A7C3B961D
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423489; cv=none; b=m7+UU2rOFOslLRO1XxZhBzDTbEZg5aNd73lql0g0dfRIHT9f9SQeqev55U3O9ypuw1P9EkQxUdo3WcEAHBAS+LlDV+KgRma2YpBh1UQV5O8jD5+1nN0Z2w+TQAWlhmkEChigG0c9I4BoLOFbMO6xESA8CEUMT0QIfGCNYn12LeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423489; c=relaxed/simple;
	bh=3dqP3pAB9z0pz66LvdchhCm4CnKTVCFZvRBtJ5taJm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZbmU6QZVtoqIqHrOY2HOwqHgHRSUj4apFqAERrl60CnJRtOVI0kdJeFOiCClsjRvRLZbUcgBQ3+LXSsYIfdntlWLLq+SAw7oHKoyyc0pqPV3usHUcd+EBOws+tZgeh3NhktegrXQZEXM70+MVv7wPN9Lxl90Zv0NNluqAaLuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C6IStHff; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C6IStHff"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id E495620B7017;
	Fri, 17 Apr 2026 03:58:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E495620B7017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423487;
	bh=4cX7kwrC8tL3yJ980nP1aC4n5bj8Kias0ChJgrNCaVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6IStHff1j2Bwd7EN76TXJIE7y5260bQaYIAsQUo/yyYZn6Dx+ZPETH9SunNpo9UF
	 9YAWVAqCF7lhDMi38YdNYvX+GhyOAlr2eas0Tfixw12EnOMG8fdhz+xpIdk1D+QLn4
	 rdnaMM+rMT6AtBQs4oz+KZzDf53Mtf7Eyzb/5Ez0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 28/34] accel/mshv: migrate REFERENCE_TIME
Date: Fri, 17 Apr 2026 12:56:12 +0200
Message-Id: <20260417105618.3621-29-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
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
index e97f480551..facdc733e7 100644
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

