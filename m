Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327463CEBA7
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688715; cv=none; b=SlSWuQjEsUKUl/Z2VmTSJd6c6+f4gBxkdmF6HZJAO27l2V5dd4Quy6VvMa5WsFHWVAW0zi1W4l+OTuarVW2R+szgMo3oM43Deq3/JgwBEwbOlSarmiWe3P/uqexz+o3RFqntm7VzkzzUAEpTC0KZcjz9R6iTYhTBO5SyVQWdIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688715; c=relaxed/simple;
	bh=InkgWW+/VHDyhaoc+fT+csd/kvb5mastzqAMS5sVaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrF+k8kaaPVbx1F6jUS++D1KBXKbmS84nT8RAilLwO5m9Fulgisza5I8OiJRgeQs8q9z43hBfj6NHagMmGh53vDTNENTzi1MZX4cRlo2d5c25aXrVEGHVR1pFD9U7uvpEe9ymHY0C2ob+oSgXQ8WAgoewK8yhWJ4/eZrfUrr32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9GXnw6/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hui5DVI+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9GXnw6/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hui5DVI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781688712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjo/PuOgMPgrqc3EuUbFNwHzptbDO7oNZxgsy6X+RuE=;
	b=h9GXnw6/FFj4C2nugoki6mKzXdaCB6vSNUs1jvCGV2BeirtEyn96qSntaVyGyEXlQS6KnY
	5MGl8oIpasjwNpErSjlCZ4I3KeHyFSBTqbcsIovRe7UzVVho3lJNcfTSJdjHkPuXXffwzx
	sCPZOvLbTRB427mh/kFTNMY/wxEp2LI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-2IWTktxqNE2V_q7NvAMpPg-1; Wed, 17 Jun 2026 05:31:50 -0400
X-MC-Unique: 2IWTktxqNE2V_q7NvAMpPg-1
X-Mimecast-MFC-AGG-ID: 2IWTktxqNE2V_q7NvAMpPg_1781688710
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b3ec3f7fso35040565e9.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781688709; x=1782293509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vjo/PuOgMPgrqc3EuUbFNwHzptbDO7oNZxgsy6X+RuE=;
        b=hui5DVI+xMXtxWXA3fzuSUk7BPXqG6HbYu0b7IcvN64RjS/0LVmXpiS5iBEb0L7BEx
         nuc+ny2qCH4yAxcnA1iaGTuWHBOV3w7Nv3/TtIozVEC/Rsc9Ul6M4debJ8ydvoF/rirB
         RRCS6xRzxBEjhYuUvzH6cXtWkAouvLN8vJbTbtBobqaMN5+5htWEi7WkItnut4omrWQi
         lKBxtr+Kt2YbSznixcG9adAaTmBL9S4IryLYmSYaFeniXREC/xkfxXx6QT+dUD2TuTHD
         im8n91C35qtJIY8UxSReLcRkFSHivOA3BzZckb0wng9NfLab2SPewlrR3/tQWmk6Rxag
         17zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688709; x=1782293509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjo/PuOgMPgrqc3EuUbFNwHzptbDO7oNZxgsy6X+RuE=;
        b=TGrtVCkju32lkvXJrcxAJi+Hwr3coNchBiS0NddLy1FDxMkkR+ZIztE99Zaeo1oEoy
         dLOXhnAVfU1NuSTdPbnb7IVZKN2d7NbGBeiUF1FDrWZ5uPTRzfVpjLp79dR3rTiGe6dP
         +DOHrLFFh6vvHg8/lvpwNBX9MrjjTSz6YBhd1nP1PZk+4LyiO7q8XKDeNFTrIYQxx5Y/
         YZxBWYP+3oOO7JeBGlkQosvrlGPDTIp+zvdD9znsoRr97AkC2JeyXMlMQiDyCnrg73sR
         LGQKdbHpA4X7IMOFxtmyO0NGFczx64srZw+LP92lyY2Q4CWuYSeWEJyzFFV1rRpUKxKs
         4ZXw==
X-Forwarded-Encrypted: i=1; AFNElJ963eBk/kK4/7mhx4X4t8Jv60toPlNfla9PECaI7ORW8mo6yAFpxa8dilsMbBS+jVozxBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaagMe7k7LDA2Ph5uNajoRPr2HYSR7aVi5Nno5G0L4msK+vWV
	gyh5yGaJ4q2IV6+ochSIyI/n1d/k6W5fRZkpURIJ44WTSgrniiHmgV37tcAGfSqYMPhT815zeDp
	a3i67X4qsmeUDcJJEkvKueBvC9Gy2w6XH09s3NIZOLBFkEqo/q627yw==
X-Gm-Gg: Acq92OEqJKqaWtcxHAvr0tU+ylcqOgExULD7v1uTT9crZL16BOfc4FG0WVA9H4KXq+8
	Wtwh4mCzkPsU0k6z1mx53EtmaKRoEvd7YjX5Pr6n8kqZbzQsI/VwnrkMTKllKD79/pJMfrB9Cz3
	cgeLXq4tm+kFI7Z+QZVX++57Iu8JrlK6dkg0Rbxp0bkZ27XMHzRMLlgnA709douiusWTIGpD+Qh
	o7DbRrwrjSU7vly1V6k92LQLJRL5EIxRDUt80OnfawbzlInd/8Mu941I31FPAHonGq8rFQcraH8
	6EvFy1phNiM65+IN6DIOuFB/aTFoBLbWiWabplM19cJlq0745aDmHf2bJCYEWQAdeK2loxqcPai
	BdBsJfKTly9OvbVSzBWbKDVfGxLWHR0vgHMQwpwxgnDampfmRFUUVrF1gwi72
X-Received: by 2002:a05:600c:a142:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-492333ca3b7mr41077525e9.19.1781688709386;
        Wed, 17 Jun 2026 02:31:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a142:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-492333ca3b7mr41076915e9.19.1781688708883;
        Wed, 17 Jun 2026 02:31:48 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233bf0881sm52263795e9.2.2026.06.17.02.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:31:48 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:31:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>, 
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	osteffen@redhat.com, pbonzini@redhat.com, stable@vger.kernel.org, tglx@kernel.org, 
	x86@kernel.org, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: KVM: x86: Unconditionally recompute CR8
 intercept on PPR update
Message-ID: <ajJnb-Bzu4S0oOP5@sgarzare-redhat>
References: <20260610214523.2905255-2-clopez@suse.de>
 <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com>
 <airudX6N4oL5X_wE@google.com>
 <79c59d84-80bc-41f6-950f-41ff2e6b2b5b@suse.de>
 <ajBGeUyhVM1-SI33@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajBGeUyhVM1-SI33@google.com>

On Mon, Jun 15, 2026 at 11:37:45AM -0700, Sean Christopherson wrote:
>On Mon, Jun 15, 2026, Carlos López wrote:
>> On 6/11/26 7:20 PM, Sean Christopherson wrote:
>> > On Thu, Jun 11, 2026, syzbot ci wrote:
>> >> ------------[ cut here ]------------
>> >> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
>> >> WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
>> >> WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
>> >> Modules linked in:
>> >> CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full)
>> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> >> RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
>> >> RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
>> >>  apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
>> >>  kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
>> >>  kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
>> >>  kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
>> >>  kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
>> >>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
>> >>  vfs_ioctl fs/ioctl.c:51 [inline]
>> >>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>> >>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>> >>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> >
>> > This is "fine", the assertion just wants to make sure KVM isn't access vmcs12
>> > without holding vcpu->mutex, otherwise any queries are inherently unstable.
>> > It's just that vCPU creation runs without taking vcpu->mutex, because the vCPU
>> > is otherwise unreachable.
>> >
>> > I'm pretty sure we can squash the WARN by grabbing vmcs12 if and only if the vCPU
>> > is actually in guest mode.
>>
>> Will you add this on top or should I send a v3?
>
>Gah, I was going to say "I'll fixup when applying", but that leads to an unwieldy
>changelog.  I'll send a v3 with this slotted in as a proper prep patch, might as
>well let syzbot have another go at it, to make sure there isn't another assertion
>lurking.

I successfully tested Carlos's v2 plus this hunk with SVSM as mentioned 
in the link in the description.

So, feel free to carry my T-b in v3:

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>> > diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
>> > index c548f22375ad..332fbcd924f2 100644
>> > --- arch/x86/kvm/vmx/vmx.c
>> > +++ arch/x86/kvm/vmx/vmx.c
>> > @@ -6876,11 +6876,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>> >
>> >  void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
>> >  {
>> > -       struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>> >         int tpr_threshold;
>> >
>> >         if (is_guest_mode(vcpu) &&
>> > -               nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
>> > +           nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
>> >                 return;
>> >
>> >         guard(vmx_vmcs01)(vcpu);
>> >
>> >
>> > Longer term, I'll work on figuring out how to handle this in get_vmcs12(), because
>> > to_hv_vcpu() has the solve the same fundamental problem:
>> >
>> > https://lore.kernel.org/all/aeqRzanSaa9P_EPg@google.com
>>
>

