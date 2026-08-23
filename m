Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99F24DCF9
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476666; cv=none; b=sjGATOh3XLLmNKc4kznMyxAPudN0oSlaZhkwhwoOqs2vIWny34mMYHV8ieOoKnPi03x9KkBiSmVt32McXkG42Wg7S7dfLJ4AhusiEZNPX8+8v9DwHxDeGe695hc0sX65wgvb6KMinGhrbWjM7iyOvWA6pc8w90YOcLMuVHI2VL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476666; c=relaxed/simple;
	bh=3plaIBwoXwGEz5vqEHuq92dc+8utBVt5RFi57XVnMDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyYIxHkt8lyC00Xv3EQs2trmbLBsqqb9apZ3+1iOd6zg5Vhajn8Y0mgJWvT3Bkwj5gEm80wiEyu9VEnTetCa39aWEJ+RBs7gEpcpDXJWe10o2B8SvEHeelpM9ut/lml4e7U6e/GEOgXACZL5Gi7gLjc71E3CimquKPHe3Q50UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvkCYWSY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvkCYWSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787476664; x=1819012664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3plaIBwoXwGEz5vqEHuq92dc+8utBVt5RFi57XVnMDg=;
  b=JvkCYWSY+8tHRX4MYDs9wwhS8ca1nzQUW+cmQYuCYKkaUzGcY2oLHWme
   pjJvtfJdwCgilnx5jJlS4nOYKIwvUoNjZCfiSWtXnwKzo6WxhU0ZGfIsH
   ljpkdN5sf+LzlbPC4YBQQzSx51/bgaqCkFvwOWFvLiNnUi3TcLAWR2ONv
   e6lESmndkLloOFPkgFyrLVq81Hd8+/F6GeFGTOXbXYTz8C8oRbtZ1P24H
   1f0G8EVkdDiESW01VaorrZIs09+yS/XZw+zZE4wXHMxvrnXPrCaZeQTUP
   JdMtIpTV+yIK2SigeNyR5QxEW9C1+DIx7gl/cD41aulGJSlyrDsPqJm8G
   A==;
X-CSE-ConnectionGUID: YZMdmQszQZyKitlS2MiWhA==
X-CSE-MsgGUID: En4PMX6fTJ67k80zYkTrYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="113492465"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="113492465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 02:17:43 -0700
X-CSE-ConnectionGUID: rEEgqJCdRdqRUusIB2+KlQ==
X-CSE-MsgGUID: ZbkYFtboRVulDUyu/tlRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="262472054"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2026 02:17:41 -0700
Date: Sun, 23 Aug 2026 17:17:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 7/9] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
Message-ID: <aoq6tHPU70oKHCub@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-8-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-8-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:54PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:54 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 7/9] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
> only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
> or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.
> 
> Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
> reports this range as reserved unless the IOMMU advertises
> FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
> that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
> -EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.
> 
> Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
> address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
> also expose the range as reserved in E820 when the vCPU can address it.
> 
> Changing the GPA layout affects migration, so enable the Hygon behavior
> through x-hygon-vendor-abi-fixes.  pc-11.0 and older machine types retain
> their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
> continues to preserve the AMD layout of pc/q35 machine types through 7.0.
> 
> Add functional tests for Dhyana with the current q35 machine type and
> with pc-q35-11.0 compatibility.
> 
> Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  hw/i386/pc.c                                  | 18 ++++++---
>  .../functional/x86_64/test_mem_addr_space.py  | 37 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2b4e322b2f..04aef6c267 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -738,6 +738,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>  #define AMD_ABOVE_1TB_START  (AMD_HT_END + 1)
>  #define AMD_HT_SIZE          (AMD_ABOVE_1TB_START - AMD_HT_START)
>  
> +static bool x86_cpu_has_amd_iommu_ht_gpa_hole(const X86CPU *cpu)
> +{
> +    return IS_AMD_CPU(&cpu->env) ||
> +           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
> +}
> +
>  void pc_memory_init(PCMachineState *pcms,
>                      MemoryRegion *system_memory,
>                      MemoryRegion *rom_memory,
> @@ -762,12 +768,14 @@ void pc_memory_init(PCMachineState *pcms,
>      linux_boot = (machine->kernel_filename != NULL);
>  
>      /*
> -     * The HyperTransport range close to the 1T boundary is unique to AMD
> -     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
> -     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
> -     * older machine types (<= 7.0) for compatibility purposes.
> +     * The HyperTransport range close to the 1T boundary is reserved by the
> +     * AMD IOMMU GPA layout.  Apply the ram-above-4g relocation only to vCPUs
> +     * that use that layout. @enforce_amd_1tb_hole preserves older AMD
> +     * machine types (<= 7.0), and x-hygon-vendor-abi-fixes preserves older
> +     * Hygon machine types (<= 11.0).
                               ^^^^^^^

nit: <= 11.1.

>       */

And x-hygon-vendor-abi-fixes is not here, or maybe we can palce all checks
in a single helper...

> -    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
> +    if (x86_cpu_has_amd_iommu_ht_gpa_hole(cpu) &&
> +        pcmc->enforce_amd_1tb_hole) {

...for example:

/*
 * The HyperTransport range close to the 1T boundary is unique to AMD &
 * Hygon hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
 * to above 1T to AMD & Hygon vCPUs only. @enforce_amd_1tb_hole is only false
 * in older machine types (<= 7.0) and @x-hygon-vendor-abi-fixes is false in
 * machine types (<= 11.1), for compatibility purposes.
 */
static inline bool x86_cpu_has_iommu_ht_gpa_hole(PCMachineState *pcms,
                                                 const X86CPU *cpu)
{
    if (!pcmc->enforce_amd_1tb_hole) {
        return false;
    }

    return IS_AMD_CPU(&cpu->env) ||
           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
}

>          /* Bail out if max possible address does not cross HT range */
>          if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
>              x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;
> diff --git a/tests/functional/x86_64/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
> index 61b4a190b4..b80f9acd99 100755
> --- a/tests/functional/x86_64/test_mem_addr_space.py
> +++ b/tests/functional/x86_64/test_mem_addr_space.py
> @@ -208,6 +208,25 @@ def test_phybits_low_tcg_q35_71_amd(self):
>          self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
>          self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>  
> +    def test_phybits_low_tcg_q35_hygon(self):

like q35-7.1 AMD case, I think it's better to record the version in test
name:

def test_phybits_low_tcg_q35_112_hygon(self):

> +        """
> +        Same as q35-7.1 AMD case except that here we check that Dhyana
> +        follows the same AMD IOMMU HT reserved GPA range on new machine
> +        types.
> +        """
> +        self.ensure_64bit_binary()
> +        self.set_machine('q35')

For compatibility checks, it's better to explicitly specify the version:

self.set_machine('pc-q35-11.2')

> +        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
> +                         '-m', '512,slots=1,maxmem=976G',
> +                         '-display', 'none',
> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
> +                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
>      def test_phybits_ok_tcg_q35_70_amd(self):
>          """
>          Same as q35-7.0 AMD case except that here we check that QEMU can
> @@ -225,6 +244,24 @@ def test_phybits_ok_tcg_q35_70_amd(self):
>          self.vm.shutdown()
>          self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
>  
> +    def test_phybits_ok_tcg_q35_110_hygon(self):

test_phybits_ok_tcg_q35_111_hygon?

> +        """
> +        Same as q35-7.1 Dhyana case except that here we check that the
> +        q35-11.0 compatibility setting keeps the old memory layout.

q35-11.1.

> +        """
> +        self.ensure_64bit_binary()
> +        self.set_machine('pc-q35-11.0')

self.set_machine('pc-q35-11.1')?

Thanks,
Zhao

