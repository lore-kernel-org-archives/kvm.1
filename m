Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774B3DD857;
	Tue, 19 May 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177779; cv=none; b=qKUfCdQg7Eck0HpD+Phv7qX/t4SKid8qPayhb3zUP1lMw4GLd+EdjuhBlvyPvAZde9vMpOz9b771WC3Yk/uUq/ZefH3koTX9diO43zyuW4U1EB4c0dxFwRLHKLr6JXr7PEicVE1dBKluIDtQ1+am5W1FCV9jhqcf4loRT2bCBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177779; c=relaxed/simple;
	bh=h0rTnLTxCM4upUudmrPgHiPfm9AkC4leOdHrzJAwMjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnR2tjj9BSDhv/f9uQDmM17YDT14uQ+1Q8qnD05g+1v1/l7Q/dGBKhIGgr+ul30/onKAzzBw5rwkRp+ecr8l5D2sDsSd0t7MoabZeRyzllyy4TPA0xZ+WQtr5cwkEqcEQw3VM55ydOd5B/W4bw/sZ9PrDes35sJUh5nxfamuN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CE269802A2;
	Tue, 19 May 2026 10:02:47 +0200 (CEST)
Message-ID: <78b03260-856a-4cce-a178-493e248dcbc9@proxmox.com>
Date: Tue, 19 May 2026 10:02:46 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, jon@nutanix.com, chao.gao@intel.com
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
 <c5b71519-a129-4711-8f98-f05b3178a96d@proxmox.com>
 <agdmi9wv8yOpgTpb@google.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <agdmi9wv8yOpgTpb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779177753551

Hi Sean,
thanks for the input.

On 5/15/26 8:31 PM, Sean Christopherson wrote:
> [...]
> Hmm, this probably confirms its the hrtimer issue?  When using the VMX preemption
> timer, KVM (on Intel) doesn't use an hrtimer to emulate L1's APIC timer.  I _think_
> forcing KVM to use an hrtimer would cause result in hrtimers being reprogrammed
> in response to KVM's usage, and thus mask the deferred reprogramming bug?  That
> sounds plausible-ish?
> [...]
> Can you try Peter's fixes?  AIUI, the reporter's hack-a-fix was very far from a
> complete fix.  Note, there's a v3 of patch 1 (b4 should take care of that for you,
> if you're using b4).
>
> https://lore.kernel.org/all/20260423155611.216805954@infradead.org

I tested it again with the v3 hrtimer patches [0] applied on top of the v6
MBEC/GMET series.

Setup:
* Host CPU: Intel(R) Core(TM) Ultra 7 265K (Arrow Lake)
* Host OS: Proxmox VE (based on Debian Trixie)
* Host Kernel: mainline kernel 7.1.0-rc4 with v6 MBEC/GMET and v3 
hrtimer [0]
* QEMU: 11.0.0 (downstream build)
* Guest OS: Windows Server 2026 (24H2, Build 26100.1742) with VBS/Hyper-V
    enabled.

Using:
* QEMU CPU Options: -cpu host,level=30,+vmx-mbec,-cet-ss,-cet-ibt

The CPU lockups did not occur anymore and I was able to boot the Guest. 
Keep
in mind that in this case I have the cet-ss and cet-ibt not passed along 
to the
guest.

If I launch the same Virtual Guest using
* QEMU CPU Options: -cpu host,level=30,+vmx-mbec,+cet-ss,+cet-ibt

The issue of the VM being stuck on boot persists even with the hrtimer 
patches
applied, but now there are no hard/soft lockups of the CPU anymore.

I get this trace using: trace-cmd record -e kvm

        CPU 0/KVM-11837 [001] d..2.  1363.314703: kvm_apic_accept_irq:  
apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-11837 [001] d..2.  1363.314703: kvm_apicv_accept_irq: 
apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-11837 [001] d..3.  1363.314703: kvm_hv_timer_state:  
  vcpu_id 0 hv_timer 1
        CPU 0/KVM-11837 [001] d..1.  1363.314703: kvm_entry:      vcpu 0 
rip 0xfffff801a59020f7
        CPU 0/KVM-11837 [001] d..1.  1363.314703: kvm_wait_lapic_expire: 
vcpu 0: delta -590 (late)
        CPU 0/KVM-11837 [001] d..1.  1363.314993: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.314994: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec
        CPU 0/KVM-11837 [001] d..1.  1363.315993: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.315993: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec
        CPU 0/KVM-11837 [001] d..1.  1363.316993: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.316994: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec
        CPU 0/KVM-11837 [001] d..1.  1363.317992: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.317993: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec
        CPU 0/KVM-11837 [001] d..1.  1363.318992: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.319269: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec
        CPU 0/KVM-11837 [001] d..1.  1363.319992: kvm_exit:      reason 
EXTERNAL_INTERRUPT rip 0xfffff801a59020ec info 0 0
        CPU 0/KVM-11837 [001] d..1.  1363.319994: kvm_entry:      vcpu 0 
rip 0xfffff801a59020ec

I did not spot anything useful in the dmesg/journalctl output.

I also did the same tests with mainline kernel
7.1.0-rc3 with v6 MBEC/GMET (patches 1-22 of 28) and v3 hrtimer [0]
and got the same results.

Best regards,
David

[0] https://lore.kernel.org/all/20260423155611.216805954@infradead.org



