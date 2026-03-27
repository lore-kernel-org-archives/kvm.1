Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384A1A08AF;
	Fri, 27 Mar 2026 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576581; cv=none; b=jPQsED6wD2oJ47z/7xr8R8WPn60B74KTJHvwUAiiL0SxUmBJNHIDP6n+5h4vyrbv0WukRghtGNIdCVzug5mDFu2j+S5di88qU8Vstz0cuYxpwGEdbiat8nP9e4ryguysOxcejK/pqb3RjC5yaHPZYRzAsnA6QoCaGFN0K0m53qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576581; c=relaxed/simple;
	bh=lR4Qr6eZbgLlGxjueIrfdHdQ8tpLSPAGt/bl6m+aneM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btsHLbez2Wl8UXR4JkFIvhV0WFWf+WQU38T0R/GiGx7rC7m5FFkp2Gb3uKYI1iZoZA5plxHwoXWPO25Gh7FnocE6ydUaYScND59Zkyft6VmZ49Mb6HO0IQY6cV34ZgN4kKSPD4xWsXhF7zlMB2/TVkAsTxn06j6jtx0mFwa2ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o8TdWYzh; arc=none smtp.client-ip=47.90.199.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o8TdWYzh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774576559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9kyhuOIWFId3eDnx5DH0/vTzPX6q9Kr9raPhodPIaWo=;
	b=o8TdWYzhNsCz7PmlKUVniW2eDgKLoO12LRQwjMpmqV+cBIDwq8f9Km1x+PXDslF2fJkabY2TdmooUTOhQ+m/A/zC3/yYMwyTBrieIg9tyaMy12XBNUpDCrmsY6Nett0kTvw99pTCRNvK/Rpw5rbmeWY9krOnC1k3dwZjm2DKydg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.mUkxK_1774576556;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X.mUkxK_1774576556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 09:55:57 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	radim.krcmar@oss.qualcomm.com
Subject: Re: Re: [PATCH v5 2/3] RISC-V: KVM: Detect and expose supported HGATP G-stage modes 
Date: Fri, 27 Mar 2026 09:55:55 +0800
Message-Id: <20260327015555.79223-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAAhSdy2uMY+-9W34G3QJ3m9XWg2dq_PeNB_9j9B3viZaRg=SUQ@mail.gmail.com>
References: <CAAhSdy2uMY+-9W34G3QJ3m9XWg2dq_PeNB_9j9B3viZaRg=SUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
>> supported by the host and record them in a bitmask. Keep tracking the
>> maximum supported G-stage page table level for existing internal users.
>>
>> Also provide lightweight helpers to retrieve the supported-mode bitmask
>> and validate a requested HGATP.MODE against it.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
>>  arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
>>  2 files changed, 34 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
>> index b12605fbca44..76c37b5dc02d 100644
>> --- a/arch/riscv/include/asm/kvm_gstage.h
>> +++ b/arch/riscv/include/asm/kvm_gstage.h
>> @@ -30,6 +30,7 @@ struct kvm_gstage_mapping {
>>  #endif
>>
>>  extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>> +extern u32 kvm_riscv_gstage_mode_mask;
>
>s/u32/unsigned long/
>s/kvm_riscv_gstage_mode_mask/kvm_riscv_gstage_supported_mode_mask/
>

Ack, will switch the type to unsigned long and rename it to
kvm_riscv_gstage_supported_mode_mask in the next revision.

>>
>>  #define kvm_riscv_gstage_pgd_xbits     2
>>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
>> @@ -75,4 +76,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>>
>>  void kvm_riscv_gstage_mode_detect(void);
>>
>> +static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
>> +{
>> +       return kvm_riscv_gstage_mode_mask;
>> +}
>> +
>> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
>> +{
>> +       return kvm_riscv_gstage_mode_mask & BIT(mode);
>> +}
>> +
>>  #endif
>> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
>> index 2d0045f502d1..328d4138f162 100644
>> --- a/arch/riscv/kvm/gstage.c
>> +++ b/arch/riscv/kvm/gstage.c
>> @@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
>>  #else
>>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
>>  #endif
>> +/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
>> +u32 kvm_riscv_gstage_mode_mask __ro_after_init;
>>
>>  #define gstage_pte_leaf(__ptep)        \
>>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>> @@ -315,42 +317,43 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>>         }
>>  }
>>
>> +static bool __init kvm_riscv_hgatp_mode_supported(unsigned long mode)
>> +{
>> +       csr_write(CSR_HGATP, mode << HGATP_MODE_SHIFT);
>> +       return ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == mode);
>> +}
>> +
>>  void __init kvm_riscv_gstage_mode_detect(void)
>>  {
>> +       kvm_riscv_gstage_mode_mask = 0;
>> +       kvm_riscv_gstage_max_pgd_levels = 0;
>> +
>>  #ifdef CONFIG_64BIT
>> -       /* Try Sv57x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
>> -               kvm_riscv_gstage_max_pgd_levels = 5;
>> -               goto done;
>> +       /* Try Sv39x4 G-stage mode */
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV39X4)) {
>> +               kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV39X4);
>> +               kvm_riscv_gstage_max_pgd_levels = 3;
>>         }
>>
>>         /* Try Sv48x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
>> +               kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV48X4);
>>                 kvm_riscv_gstage_max_pgd_levels = 4;
>> -               goto done;
>>         }
>>
>> -       /* Try Sv39x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV39X4) {
>> -               kvm_riscv_gstage_max_pgd_levels = 3;
>> -               goto done;
>> +       /* Try Sv57x4 G-stage mode */
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV57X4)) {
>> +               kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV57X4);
>> +               kvm_riscv_gstage_max_pgd_levels = 5;
>>         }
>>  #else /* CONFIG_32BIT */
>>         /* Try Sv32x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
>> +               kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV32X4);
>>                 kvm_riscv_gstage_max_pgd_levels = 2;
>> -               goto done;
>>         }
>>  #endif
>>
>> -       /* KVM depends on !HGATP_MODE_OFF */
>> -       kvm_riscv_gstage_max_pgd_levels = 0;
>> -
>> -done:
>
>Here are some statements from RISC-V privilege specification:
>"Implementations that support Sv48 must also support Sv39."
>"Implementations that support Sv57 must also support Sv48."
>"The conversion of an Sv32x4, Sv39x4, Sv48x4, or Sv57x4 guest physical
>address is accomplished with the
>same algorithm used for Sv32, Sv39, Sv48, or Sv57, as presented in
>Section 12.3.2, except that:"
>"hgatp substitutes for the usual satp;"
>
>Based on above it is a waste to try each and every mode.
>For example: if mode Sv48x4 is supported then Sv39x4 is also supported.
>

Radmi and I discussed this topic before; please refer to the following link:
https://lore.kernel.org/linux-riscv/20260131061238.52708-1-fangyu.yu@linux.alibaba.com/

>Regards,
>Anup

Thanks,
Fangyu
