Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EF32B133
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169467; cv=none; b=O0AvyAAx7P3uVez9zBOdVdXu+ofLRIrgeGQT+0MzCH513dklZp1oCfuvY0WiXAFnAp9uKwj/x4lsTBjx81E+9GDeOPFXxInxhPprzEx9TS59Ftx4Yi96jyjPK4RTKS318lIMaRIJls/iPZ2Gmf9tWEsJiymFpGAvDManMt6IF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169467; c=relaxed/simple;
	bh=X8CQR3SiGnSOFLWoY3WhbtJ5+gHQprUmR4L5YcYMYzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7Xq7Y1QGXw/c6PhW+6AskxxzyxVQFGk5/yUbKT2WOzX9L20iTUi9bhJU2G/CVnjvFwJ3/bY6r6AXNqk/V4uHxPXTuKEPE6KkPjljVOFYQJ1xiC4zRcf80mTwg3sv5Wy3dn0U2ZPwFQ47pwLEzEA7RXHCocDGsHKlEAbBXSo1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkitWU6G; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkitWU6G"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so619621eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169465; x=1790774265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyGOeMM6N9WmW/Btrmx0VVv+jU00kmaZZ+J9OFmIWlc=;
        b=GkitWU6GUoSUP9qO7qNrWZjIxATMKC/D6CE7VgzN/McK5OrnxFTedLGTLwBR0zYEhp
         +cy8A2Awyg8FLws7QfEPjnBf9/RLmfHpKHIYRhEWteAFAYOtjv04Oajla8a3NBIW+JNY
         1CCYI1fUAdT9Ewc38itC5MOVf7E5Z0v0aoekjznNQg2jt4+HTvRcU/j/1cxrzSTumxgS
         pGwfiV0GM9MW4iYOHuWVipdslzWBwUbyOIKddPRE0jdH2EYJrTZJ+PE08i/m8BTZvynA
         cou+c8rIk46ykYz84ozGa6IYdlOle38zHHm5awAZby/ngsVryo39fBeieT0OYpf2KXP9
         nfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169465; x=1790774265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VyGOeMM6N9WmW/Btrmx0VVv+jU00kmaZZ+J9OFmIWlc=;
        b=Zu2SPIciQdzXImcMsRZHRPdXCovIL/qhE1j2PCF9XQzfYEHuBNP9PEmXO/MYp7J7Ts
         /e57ws+xdOzDW4y2ZX/3eeYSd85Y+JX+La+CnYX9Mkw9lBSfWS631LwFrKY75A/YlCvK
         YcuoFa+MlHb5RIGTwWAyTxMrvPDDOf34fqCCFkVG8hLtp3AEFjQo02tdnkO81GWSpoV1
         9EoIPb/uYZtm/YO9ptd0JWcRtWvDd0wi9exlyyvjVOWf37O9lrh2gxoHQ7zR1sdsZglN
         AsZUWLtb1uQwgR9qPnxpOxjkvXjtWwA4UJ9HWzEatf+sAhsoY17WX/7GccQJRi9al2cO
         uYCg==
X-Forwarded-Encrypted: i=1; AKwUvByQlU3utUMZyXioHaWHoZhZ3/ZlukbWnyjBOi2UQxCXAGMMoHbEkL7AzNBfbjPuM35ThJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lBPdfLD1ABzrP48fjemN1JOt1FUTPqadOycuTCHmyfvVNNucYa
	SrIyhXZEoTtRSdYxh3WwVWeCCWjQjEcOwr8N6IYk95TFkTyzlwAoyKue
X-Gm-Gg: AYBFou0KCX625a/ZxTso27im5cHD11rQnTZfTBbVzMcLZ5lLcTuqqP7Rgsajwe9shOv
	OFDcGr+pxumTFyrQvxpeWACFQ0GHI/AZIe5due/O4+PFY2RPU0Ua7yX2QybW3NAqstXlToqdzyF
	B1FvRyXLDzmM7wkxpjwSPWdUXD1lhTqvuaxUQ21rPKexSSBQAukXprKELqHLXyd3SRrUptBADFo
	2F2IOLypq6SXkF2xHdm928krCnKL8B3tCx1M9NZmPOeog1tY8K04Mncw3JNIG6wfsRychqh82CX
	bt+s5jbdnbSuDo5OjLWwOCymw4dfEfJOFOzH3qmxNDwEzm8jct434MyoaxeTRBNK36n6o76lPb6
	9tggSQg7C2ct/w1A6s5qjdvAfE7IXlLps0+rrwoYd7jkFVf7l6lA0bi1pcO42sSTxH3B66ClWhQ
	YqjlqZVObceWdUSG1s+pocsqmup2rCWwTCvDWgPjoz1C3LSORtnla36Y2t9DQc8NMKpAePWVpnz
	4GeAzt4ZR0uS5cEXRzBoPMTO0f/psQ=
X-Received: by 2002:a05:693c:6394:20b0:339:8343:a1a with SMTP id 5a478bee46e88-33e8e1b7329mr2469431eec.41.1790169464712;
        Wed, 23 Sep 2026 06:17:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:17:42 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 006/114] target: remove CPU_RESOLVING_TYPE
Date: Wed, 23 Sep 2026 21:14:40 +0800
Message-ID: <20260923131635.1894-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_type is TYPE_${TARGET_BASE_ARCH}_CPU, so the per-target
CPU_RESOLVING_TYPE macros are unused. Drop them from every
target cpu.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/alpha/cpu.h      | 2 --
 target/arm/cpu.h        | 2 --
 target/avr/cpu.h        | 2 --
 target/hexagon/cpu.h    | 1 -
 target/hppa/cpu.h       | 2 --
 target/i386/cpu.h       | 2 --
 target/loongarch/cpu.h  | 2 --
 target/m68k/cpu.h       | 2 --
 target/microblaze/cpu.h | 2 --
 target/mips/cpu.h       | 2 --
 target/or1k/cpu.h       | 2 --
 target/ppc/cpu.h        | 2 --
 target/riscv/cpu.h      | 2 --
 target/rx/cpu.h         | 2 --
 target/s390x/cpu.h      | 3 ---
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 2 --
 target/tricore/cpu.h    | 2 --
 target/xtensa/cpu.h     | 2 --
 19 files changed, 38 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..a6ffe7eec29 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -433,8 +433,6 @@ void alpha_translate_init(void);
 void alpha_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
-
 G_NORETURN void dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 G_NORETURN void arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..359d86e2c37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2395,8 +2395,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
-
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
 
 /* Indexes used when registering address spaces with cpu_address_space_init */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 1e4e839bd83..747655543d4 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -30,8 +30,6 @@
 #error "AVR 8-bit does not support user mode"
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
-
 /*
  * AVR has two memory spaces, data & code.
  * e.g. both have 0 address
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index e79d8000304..54b0d69a827 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -52,7 +52,6 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
 #define MAX_TLB_ENTRIES 1024
 #define THREADS_MAX 16
 
-#define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 #ifndef CONFIG_USER_ONLY
 #define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
 #define CPU_INTERRUPT_K0_UNLOCK CPU_INTERRUPT_TGT_INT_1
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f9..35b6b8af82a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -339,8 +339,6 @@ void hppa_translate_init(void);
 void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
                          int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
-
 static inline vaddr hppa_form_gva_mask(uint64_t gva_offset_mask,
                                        uint64_t spc, target_ulong off)
 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd0..eba184035d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2813,8 +2813,6 @@ void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
 /* hw/pc.c */
 uint64_t cpu_get_tsc(CPUX86State *env);
 
-#define CPU_RESOLVING_TYPE TYPE_X86_CPU
-
 #ifdef TARGET_X86_64
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
 #else
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f698853..5d79ea836bf 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -553,6 +553,4 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
-#define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
-
 #endif /* LOONGARCH_CPU_H */
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..b3962910ad1 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -579,8 +579,6 @@ enum {
     ACCESS_DATA  = 0x20, /* Data load/store access        */
 };
 
-#define CPU_RESOLVING_TYPE TYPE_M68K_CPU
-
 /* MMU modes definitions */
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b94..00ceaf1acf7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -401,8 +401,6 @@ void mb_tcg_init(void);
 void mb_translate_code(CPUState *cs, TranslationBlock *tb,
                        int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
-
 /* MMU modes definitions */
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..0d2846eaf58 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1359,8 +1359,6 @@ enum {
  */
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
 
-#define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
-
 bool cpu_type_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask);
 bool cpu_type_supports_isa(const char *cpu_type, uint64_t isa);
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index fc4387ce7ae..34586755baf 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -320,8 +320,6 @@ void cpu_openrisc_count_start(OpenRISCCPU *cpu);
 void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
-
 #define TB_FLAGS_SM    SR_SM
 #define TB_FLAGS_DME   SR_DME
 #define TB_FLAGS_IME   SR_IME
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 217b4f334e5..c11d64677df 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -29,8 +29,6 @@
 #include "qom/object.h"
 #include "hw/core/registerfields.h"
 
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
-
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a97f30793b9..034d7e96c49 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,8 +36,6 @@
 
 typedef struct CPUArchState CPURISCVState;
 
-#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
-
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 233615c32dc..49188c36c57 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -144,8 +144,6 @@ struct RXCPUClass {
     ResettablePhases parent_phases;
 };
 
-#define CPU_RESOLVING_TYPE TYPE_RX_CPU
-
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 998bbb0d7ff..c77b297a26a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -860,9 +860,6 @@ static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 }
 
 
-/* helper.c */
-#define CPU_RESOLVING_TYPE TYPE_S390_CPU
-
 /* interrupt.c */
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d440aa6dbe7..eaf67fe8e6a 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -304,8 +304,6 @@ int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define CPU_RESOLVING_TYPE TYPE_SUPERH_CPU
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af03..fd409e74948 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -663,8 +663,6 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
-
 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
 #define MMU_USER_IDX   0
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7a..346b0e1f3f3 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -257,8 +257,6 @@ void tricore_tcg_init(void);
 void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
-
 /* helpers.c */
 bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                           MMUAccessType access_type, int mmu_idx,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0b2cb5a250d..ee8d9c10b16 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -603,8 +603,6 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                uintptr_t retaddr);
 G_NORETURN void xtensa_exception(CPUXtensaState *env, uint32_t excp);
 
-#define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
-
 #if TARGET_BIG_ENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
 #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
-- 
2.52.0.windows.1

