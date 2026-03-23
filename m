Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2303B8954
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274363; cv=none; b=Sl+1LK2CcsHUgHq4ajRZ0NmASe+7X+4crpaSfvt6Nq8pzFpFpDk7PFbAeso+cA2+pJqT9188+0u2ubOmos0TLLr9hMoiJZW/QDcucVmHojlkmRzmpdmkdsPcJF1VJuFWEezMHyx/iSaLvpbT4QEUQcxMku4oVUqD1zMO2FhUwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274363; c=relaxed/simple;
	bh=L+4WX3rf0ByxbbSlzZTmxJKErJpxXtD0p0m8crB6kps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffQRzzPID21Lm0gDj5TGbzw54AFObhQGO9RbOsDCNJvIF8Ak6bGOJPzy5oMGTdxvj1K14IZTQL10ZxoOW0QeAg60xJy57zgKRMGhDhHS3uVEPBMBFuD9UAogV9g043Rihh5/wnffRn6LFnrWR96PZodcmRiVFIUlOPqpmVw4AX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NoeyWSSt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NoeyWSSt"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85EFE20B6F0C;
	Mon, 23 Mar 2026 06:59:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85EFE20B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274361;
	bh=OQujwAZOqX2qQUO+ZXBx8ttJK+qeeuCMDCt1NJaHUSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoeyWSSt+dIrj8giZcWklm+Y9AptfNIcDh8IOcnaYBjlz5Os9MWvifc/MfDlJ29xE
	 1U6QdD+eGy8pAQSzsQjA1zNioIvm4UtPVnSdocmj22vfxbgUE+4TmSvsu8x2jRHVhH
	 4ek9uRGWcPr65VVRYi/ADaI3h2tL3iahMSUwYZ8w=
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
Subject: [RFC 17/32] accel/mshv: store partition proc features
Date: Mon, 23 Mar 2026 14:57:57 +0100
Message-Id: <20260323135812.383509-18-magnuskulke@linux.microsoft.com>
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

We retrieve and store processor features on the state, so we can query
them later when deciding which MSRs to migrate.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c     |  57 +++++++++++++++
 include/hw/hyperv/hvhdk.h | 149 ++++++++++++++++++++++++++++++++++++++
 include/system/mshv_int.h |   2 +
 3 files changed, 208 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 056b19b3b8..d1bf148bb8 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -106,6 +106,57 @@ static int resume_vm(int vm_fd)
     return 0;
 }
 
+static int get_partition_property(int vm_fd, uint32_t property_code,
+                                  uint64_t *value)
+{
+    struct hv_input_get_partition_property in = {0};
+    struct hv_output_get_partition_property out = {0};
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    in.property_code = property_code;
+
+    args.code    = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz   = sizeof(in);
+    args.in_ptr  = (uint64_t)&in;
+    args.out_sz  = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = ioctl(vm_fd, MSHV_ROOT_HVCALL, &args);
+    if (ret < 0) {
+        error_report("Failed to get guest partition property bank: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    *value = out.property_value;
+    return 0;
+}
+
+static int get_proc_features(int vm_fd,
+                             union hv_partition_processor_features *features)
+{
+    int ret;
+
+    ret = get_partition_property(vm_fd,
+                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
+                                 features[0].as_uint64);
+    if (ret < 0) {
+        error_report("Failed to get processor features bank 0");
+        return -1;
+    }
+
+    ret = get_partition_property(vm_fd,
+                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
+                                 features[0].as_uint64);
+    if (ret < 0) {
+        error_report("Failed to get processor features bank 1");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int create_partition(int mshv_fd, int *vm_fd)
 {
     int ret;
@@ -441,6 +492,12 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     s->vm = vm_fd;
     s->fd = mshv_fd;
+
+    ret = get_proc_features(vm_fd, &s->processor_features);
+    if (ret < 0) {
+        return -1;
+    }
+
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 866c8211bf..5177cfa7e5 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -11,6 +11,16 @@
 
 #define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
 
+struct hv_input_get_partition_property {
+    uint64_t partition_id;
+    uint32_t property_code; /* enum hv_partition_property_code */
+    uint32_t padding;
+} QEMU_PACKED;
+
+struct hv_output_get_partition_property {
+    uint64_t property_value;
+} QEMU_PACKED;
+
 struct hv_input_set_partition_property {
     uint64_t partition_id;
     uint32_t property_code; /* enum hv_partition_property_code */
@@ -246,4 +256,143 @@ typedef struct hv_input_register_intercept_result {
     union hv_register_intercept_result_parameters parameters;
 } hv_input_register_intercept_result;
 
+#define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
+#define HV_PARTITION_PROCESSOR_FEATURES_RESERVEDBANK1_BITFIELD_COUNT 4
+
+union hv_partition_processor_features {
+    uint64_t as_uint64[HV_PARTITION_PROCESSOR_FEATURES_BANKS];
+    struct {
+        uint64_t sse3_support:1;
+        uint64_t lahf_sahf_support:1;
+        uint64_t ssse3_support:1;
+        uint64_t sse4_1_support:1;
+        uint64_t sse4_2_support:1;
+        uint64_t sse4a_support:1;
+        uint64_t xop_support:1;
+        uint64_t pop_cnt_support:1;
+        uint64_t cmpxchg16b_support:1;
+        uint64_t altmovcr8_support:1;
+        uint64_t lzcnt_support:1;
+        uint64_t mis_align_sse_support:1;
+        uint64_t mmx_ext_support:1;
+        uint64_t amd3dnow_support:1;
+        uint64_t extended_amd3dnow_support:1;
+        uint64_t page_1gb_support:1;
+        uint64_t aes_support:1;
+        uint64_t pclmulqdq_support:1;
+        uint64_t pcid_support:1;
+        uint64_t fma4_support:1;
+        uint64_t f16c_support:1;
+        uint64_t rd_rand_support:1;
+        uint64_t rd_wr_fs_gs_support:1;
+        uint64_t smep_support:1;
+        uint64_t enhanced_fast_string_support:1;
+        uint64_t bmi1_support:1;
+        uint64_t bmi2_support:1;
+        uint64_t hle_support_deprecated:1;
+        uint64_t rtm_support_deprecated:1;
+        uint64_t movbe_support:1;
+        uint64_t npiep1_support:1;
+        uint64_t dep_x87_fpu_save_support:1;
+        uint64_t rd_seed_support:1;
+        uint64_t adx_support:1;
+        uint64_t intel_prefetch_support:1;
+        uint64_t smap_support:1;
+        uint64_t hle_support:1;
+        uint64_t rtm_support:1;
+        uint64_t rdtscp_support:1;
+        uint64_t clflushopt_support:1;
+        uint64_t clwb_support:1;
+        uint64_t sha_support:1;
+        uint64_t x87_pointers_saved_support:1;
+        uint64_t invpcid_support:1;
+        uint64_t ibrs_support:1;
+        uint64_t stibp_support:1;
+        uint64_t ibpb_support:1;
+        uint64_t unrestricted_guest_support:1;
+        uint64_t mdd_support:1;
+        uint64_t fast_short_rep_mov_support:1;
+        uint64_t l1dcache_flush_support:1;
+        uint64_t rdcl_no_support:1;
+        uint64_t ibrs_all_support:1;
+        uint64_t skip_l1df_support:1;
+        uint64_t ssb_no_support:1;
+        uint64_t rsb_a_no_support:1;
+        uint64_t virt_spec_ctrl_support:1;
+        uint64_t rd_pid_support:1;
+        uint64_t umip_support:1;
+        uint64_t mbs_no_support:1;
+        uint64_t mb_clear_support:1;
+        uint64_t taa_no_support:1;
+        uint64_t tsx_ctrl_support:1;
+        uint64_t reserved_bank0:1;
+
+        /* N.B. Begin bank 1 processor features. */
+        uint64_t a_count_m_count_support:1;
+        uint64_t tsc_invariant_support:1;
+        uint64_t cl_zero_support:1;
+        uint64_t rdpru_support:1;
+        uint64_t la57_support:1;
+        uint64_t mbec_support:1;
+        uint64_t nested_virt_support:1;
+        uint64_t psfd_support:1;
+        uint64_t cet_ss_support:1;
+        uint64_t cet_ibt_support:1;
+        uint64_t vmx_exception_inject_support:1;
+        uint64_t enqcmd_support:1;
+        uint64_t umwait_tpause_support:1;
+        uint64_t movdiri_support:1;
+        uint64_t movdir64b_support:1;
+        uint64_t cldemote_support:1;
+        uint64_t serialize_support:1;
+        uint64_t tsc_deadline_tmr_support:1;
+        uint64_t tsc_adjust_support:1;
+        uint64_t fzl_rep_movsb:1;
+        uint64_t fs_rep_stosb:1;
+        uint64_t fs_rep_cmpsb:1;
+        uint64_t tsx_ld_trk_support:1;
+        uint64_t vmx_ins_outs_exit_info_support:1;
+        uint64_t hlat_support:1;
+        uint64_t sbdr_ssdp_no_support:1;
+        uint64_t fbsdp_no_support:1;
+        uint64_t psdp_no_support:1;
+        uint64_t fb_clear_support:1;
+        uint64_t btc_no_support:1;
+        uint64_t ibpb_rsb_flush_support:1;
+        uint64_t stibp_always_on_support:1;
+        uint64_t perf_global_ctrl_support:1;
+        uint64_t npt_execute_only_support:1;
+        uint64_t npt_ad_flags_support:1;
+        uint64_t npt1_gb_page_support:1;
+        uint64_t amd_processor_topology_node_id_support:1;
+        uint64_t local_machine_check_support:1;
+        uint64_t extended_topology_leaf_fp256_amd_support:1;
+        uint64_t gds_no_support:1;
+        uint64_t cmpccxadd_support:1;
+        uint64_t tsc_aux_virtualization_support:1;
+        uint64_t rmp_query_support:1;
+        uint64_t bhi_no_support:1;
+        uint64_t bhi_dis_support:1;
+        uint64_t prefetch_i_support:1;
+        uint64_t sha512_support:1;
+        uint64_t mitigation_ctrl_support:1;
+        uint64_t rfds_no_support:1;
+        uint64_t rfds_clear_support:1;
+        uint64_t sm3_support:1;
+        uint64_t sm4_support:1;
+        uint64_t secure_avic_support:1;
+        uint64_t guest_intercept_ctrl_support:1;
+        uint64_t sbpb_supported:1;
+        uint64_t ibpb_br_type_supported:1;
+        uint64_t srso_no_supported:1;
+        uint64_t srso_user_kernel_no_supported:1;
+        uint64_t vrew_clear_supported:1;
+        uint64_t tsa_l1_no_supported:1;
+        uint64_t tsa_sq_no_supported:1;
+        uint64_t lass_support:1;
+        uint64_t idle_hlt_intercept_support:1;
+        uint64_t msr_list_support:1;
+    } QEMU_PACKED;
+};
+
 #endif /* HW_HYPERV_HVHDK_H */
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index f86c7a3be6..2b6d7b2f35 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -15,6 +15,7 @@
 #define QEMU_MSHV_INT_H
 
 #define MSHV_MSR_ENTRIES_COUNT 64
+#include "hw/hyperv/hvhdk.h"
 
 struct mshv_get_set_vp_state;
 
@@ -55,6 +56,7 @@ struct MshvState {
     int nr_allocated_irq_routes;
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
+    union hv_partition_processor_features processor_features;
 };
 
 typedef struct MshvMsiControl {
-- 
2.34.1

