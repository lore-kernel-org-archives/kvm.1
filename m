Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B1296BD2;
	Wed, 15 Apr 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236816; cv=none; b=E9I3//B0PHQg0tUsuso81PBPxOTBTooVvWDkoKAYf2YFlE9UifC75arcQKLfuA8izKRi9VYqE5hlSzECgJlvFC71tZ+t2KQlGUqRwaK3qAWy7OLrsz1ojWf3mWe8m4SjatgsM6PHpkR4Lmu1qRgmK/uFT7v9wzT3/YM79bexoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236816; c=relaxed/simple;
	bh=3TFKGRtVNcNpBOuHU9lx/9ncTnlhYygAo/jXlsQnWnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjuVzhyb0b1v+WpUREiOTo10Nd6o0URpd49e9s+G0NKToiJKMqS4OrgHF1I+tFcIwUfuWs90uzkD8zxmXi/dAPC7TnsuDahSMNmsIx7bERveifpc4E6xwnChrE5ogrR/3C3jzuJlzYNZIx6i82AqzxWv5iGas+BnYkQFkDBLGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8C4A444DBE;
	Wed, 15 Apr 2026 09:06:51 +0200 (CEST)
Message-ID: <c91391f4-57b8-4bad-aba8-2c47c285ab27@proxmox.com>
Date: Wed, 15 Apr 2026 09:06:50 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/27] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Amit Shah <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1776236733511

Hi Paolo, Jon,

Thanks to Paolo for sending the new patch series (v3), and to Jon
for the feedback on my previous test.

I have once again tested this patchset (v3) on both Intel and AMD
platforms using Proxmox VE (based on Debian Trixie) with a Windows
Server guest (24H2, Build 26100.1742).

The focus of the tests were live migrations between different hosts
(Intel <-> Intel & AMD <-> AMD).

All tests used the same base setup:

Kernel: mainline 7.0.0-rc7 (with MBEC/GMET v3 patches applied)
QEMU: our downstream QEMU build based on 10.2.1, plus Jon's patches
virtio-win: 0.1.271

Windows Guest:
For the guest setup I enabled Virtualization-Based Security (VBS)
and Hypervisor-Protected Code Integrity (HVCI).

I set the following in the Group Policy Editor (DeviceGuard):
* Select Platform Security Level: Secure Boot
* Virtualization Based Protection of Code Integrity: Enabled without
   lock
* Require UEFI Memory Attributes Table: Checked

Hosts:
Intel Nodes:
    CPU: Intel(R) Xeon(R) Gold 6426Y

AMD Nodes:
    CPU: AMD EPYC 7302P


I tested the following:

1. Intel without Hyper-V Enlightenments:

QEMU CPU options: -cpu 'host,+kvm_pv_eoi,+kvm_pv_unhalt,level=30'
AvailableSecurityProperties [0]:  1,2,4,5,7

Security Property 7 indicates MBEC/GMET support. [0]

I migrated the virtual guest between the two Intel hosts whilst
running Cinebench R32.200. No issues were found, but the VM does not
perform well without Hyper-V Enlightenments.

2. Intel with Hyper-V Enlightenments:

QEMU CPU options: -cpu 'host,+hv-evmcs,+hv-ipi,+hv-relaxed,
   +hv-runtime,hv-spinlocks=0x1fff,+hv-stimer,+hv-synic,+hv-time,
+hv-tlbflush,+hv-tlbflush-ext,+hv-vapic,+hv-vpindex,+hv-xmm-input,
   +kvm_pv_eoi,+kvm_pv_unhalt,level=30,+vmx-mbec'

AvailableSecurityProperties [0]: 1,2,4,5,7

I again migrated the virtual machine between the two Intel hosts
whilst running Cinebench R32.200. No issues were found, but the VM
performs significantly better with Hyper-V Enlightenments set.

3. AMD without Hyper-V Enlightenments:

QEMU CPU options: -cpu 'host,+kvm_pv_eoi,+kvm_pv_unhalt,level=30'

AvailableSecurityProperties [0]: 1,2,4,5,7

I migrated the virtual machine between the two AMD hosts whilst
running Cinebench R32.200. No issues were found.

4. AMD with Hyper-V Enlightenments:

QEMU CPU options: -cpu 'host,+gmet,+hv-emsr-bitmap,+hv-ipi,
+hv-relaxed,+hv-runtime,hv-spinlocks=0x1fff,+hv-stimer,+hv-synic,
   +hv-time,+hv-tlbflush,+hv-tlbflush-ext,+hv-vapic,+hv-vpindex,
   +hv-xmm-input,+kvm_pv_eoi,+kvm_pv_unhalt,level=30'

AvailableSecurityProperties [0]: 1,2,4,5,7

I again migrated the virtual machine between the two AMD hosts whilst
running Cinebench R32.200. I have not found any issues.

Tested-by: David Riley <d.riley@proxmox.com>

[0] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security


