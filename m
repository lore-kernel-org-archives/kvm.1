Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D63A5421;
	Tue,  7 Apr 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562847; cv=none; b=rcc2g6JYI0Zqx1MvxCwOxNMvrUEPTBswb5hpK/63OsFgggIVmcplSjpdgQUvrq/h1JsWSKxe8Wyxt/vyrb9bY5Obts9RsoXMOljocV7t8b5Pm9pO9aU5z9mX0td3PaeqV3lSmgDULhicWl4itV1LgXMy3q/r4y1cYCtcGxZ8xA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562847; c=relaxed/simple;
	bh=vjPzgtDZ0J/+hGhGp69WyBWWi7O1g+BjRZed8jqVdOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rldQDYonMXKiNe4dXViZFbJRInrMyFOyL2oF2IR+4pwhesM2qpy9VdBcPQrjgOwxPsACpay7tqOdDmJjeWQYotMgKvBkda+yjyEHUCFhmPZvBJkM3DN9XwVebj00NXSLxRO2XsXr87Qsvsf+vpO9NBMUqvJdIUnQxHb7krg+6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F3051440BE;
	Tue, 07 Apr 2026 13:53:55 +0200 (CEST)
Message-ID: <a7c32e69-afab-4289-95e3-330cc73f00d2@proxmox.com>
Date: Tue, 7 Apr 2026 13:53:54 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Amit Shah <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1775562768925

Hi Paolo, Jon,

Thank you for your work on this!

I have tested this patchset (v2) on both Intel and AMD platforms using
Proxmox VE (based on Debian Trixie) with a Windows Server
(24H2, Build 26100.1742) guest.
The focus of the test were the performance improvements when using
Virtualization-Based Security (VBS) and Hypervisor-Protected Code
Integrity (HVCI).

Environments

Intel Node:
   CPU: Intel(R) Xeon(R) Gold 6426Y
   Kernel: mainline 7.0.0-rc5 (with MBEC/GMET patches applied)
   QEMU: our downstream QEMU build based on 10.2.1, plus Jon's patches
   QEMU CPU option: -cpu host,level=30,+/-vmx-mbec,hv_relaxed,hv_reset,
hv_runtime,hv_time,hv_spinlocks=0x1fff,hv_vapic,hv_vpindex,hv_ipi,
     hv_synic,hv_stimer,hv_apicv,hv_xmm_input,hv_stimer_direct,
     hv_frequencies,hv_reenlightenment,hv_evmcs,hv_emsr_bitmap,
     hv_tlbflush,hv_tlbflush_ext,hv_tlbflush_direct
   virtio-win: 0.1.271

AMD Node:
   CPU: AMD EPYC 7302P
   Kernel: mainline 7.0.0-rc5 (with MBEC/GMET patches applied)
   QEMU: our downstream QEMU build based on 10.2.1, plus Jon's patches
   QEMU CPU option: -cpu host,level=30,+/-gmet,hv_relaxed,hv_reset,
hv_runtime,hv_time,hv_spinlocks=0x1fff,hv_vapic,hv_vpindex,hv_ipi,
     hv_synic,hv_stimer,hv_apicv,hv_xmm_input,hv_stimer_direct,
     hv_frequencies,hv_reenlightenment,hv_emsr_bitmap,hv_tlbflush,
     hv_tlbflush_ext,hv_tlbflush_direct
   virtio-win: 0.1.285

QEMU Patches: I manually integrated Jon Kohler's QEMU patch series [0]
(Patches 1-3) to enable feature exposure to the guest.

In the guest, the Win32_DeviceGuard output confirms MBEC/GMET
availability via the presence of value 7 in
AvailableSecurityProperties [1].

Methodology

I enabled VBS and Memory Integrity (HVCI) via Group Policy within
the guest. I collected VM-Exit samples using perf kvm stat on the
host while running a small script intended to provoke high-frequency
mode-transitions [2] inside the guest for 25 seconds ("Load" in the
table below). I did the same measurements without running the script
to get the measurements for the idle state ("Idle" in the table
below).

Results

I compared the VM-Exit volume by running the workload with the feature
flags (+vmx-mbec / +gmet) enabled vs. disabled. The table below shows
the average number of samples (Total count of VM-Exit Events) over
the 3 runs for each mode (idle/load).

Platform  Mode  #Avg Exits Disabled  #Avg Exits Enabled  Reduction
Intel          Idle          631722                   189460             
       70.01%
Intel          Load   10020824                    775194               
92.26%
AMD         Idle          249200                    118042               
   52.63%
AMD         Load        425217                    306945               
27.81%

Observations

Intel MBEC:
The reduction in VM-exits is massive (over 92% under load).

AMD GMET:
There is a measurable benefit (~28% reduction), though it appears less
significant than the Intel results. However, it is worth noting that the
AMD platform maintains a much lower baseline of VM-exits even with
the feature disabled, suggesting more efficient native handling of
these transitions compared to the Intel baseline in this specific test
environment.

On both architectures, I did not notice any stability issues with the
patches applied.

Let me know if there are more specific tests you're interested in.

Tested-by: David Riley <d.riley@proxmox.com>

[0] 
https://lore.kernel.org/qemu-devel/20260330193428.1663253-2-jon@nutanix.com/
[1] 
https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security
[2]

$Duration = 25
$StopWatch = [System.Diagnostics.StopWatch]::StartNew()

while($StopWatch.Elapsed.TotalSeconds -lt $Duration) {
     for ($i = 0; $i -lt 100; $i++) {
         $Value = Get-Random -Maximum 1000
         $Code = [scriptblock]::Create("($Value * 2) / 2")
         $Code.Invoke() | Out-Null
     }
     Start-Sleep -Milliseconds 20
}


