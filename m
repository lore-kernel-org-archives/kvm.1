Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979242E8FF
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997917; cv=none; b=d7liRQyCwwkgJM2Lw3ruscGa+1kX9vxLXE0GRqnE/Y3Lx0wILbVLqFNKxrBC9v+ZrXKjwIYp6e6Jauy6P4J20jMf75zw0cSUXxIaue6jx5cv5XOU8dPvFTZ/w9U05Wkf0mT9OG+pKIDT5vyN4ZiojYQfaqtLxV5+U8iY3uEtd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997917; c=relaxed/simple;
	bh=RfjQB9IEwKvpLy3g8A9YYqTZwmI6upu1Ov8jKrg4rn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4ycPUi6u2XOEpSkbkfVoZ7B08WnAbWcZjZX2Y+Zj7yJWv7aoHNBoIRLhRGglnAXCDG8TYw/hPlPl+mhR8SP4ORIQoJJMvt6Zw1KL8XRl+VGOnQebCSc+2g3aLJCdFJOh25QUI8nK0ofmji1WLVjn2qlOuH9WYtfR8FeDzRN/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XQpa7uBk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XQpa7uBk"
Received: from example.com (unknown [167.220.208.73])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95F9220B7167;
	Thu,  2 Jul 2026 06:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95F9220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782997913;
	bh=KjWxs47FrqE58lRtkZlQudRjJ8DeMoQhjDC1mCt8QmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQpa7uBkUFxCWuuq5e/QgHSyhHNv2e4U8bCh1dfhYWQyPFtEbcLV3Oc/Km0AOxGwq
	 KdvgGeAf66YEscsKkUpzhqmkKWOeziMcMyxzpEl0FtFdQ0UPOp7aTEkIFWWLcUjWyO
	 6XNIEtsX0fVX2aOnGWeZvRhQNlYdprs08VOKRJ3w=
Date: Thu, 2 Jul 2026 15:11:49 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	kvm <kvm@vger.kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <akZjldXYFQ7Fchoo@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
 <akY0Gpd/GHj3Pdun@example.com>
 <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
 <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>

On Thu, Jul 02, 2026 at 02:38:24PM +0200, Mohamed Mediouni wrote:
> > On 2. Jul 2026, at 13:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > What is the issue? The interrupt won't be triggered either if you use a separate field, or if you use the normal one.
> 
> Hi,
> 
> For injecting LINT0, it’s possible on modern WHPX when using the hw irqchip
>  - starting from Server 2022/Windows 11 only - not before that point.
> 
> How it’s done is though cancelling the vCPU execution, wait until the vm exits
> as a result, set an interrupt window, run the vCPU again and then when it exits
> Manually injecting an event…
> 
> That’s unlike non-legacy interrupts where the request interrupts path actually
> works on Hyper-V.
> 
> > 
> > For LINT1, can you not inject an NMI either?
> 
> The request interrupt path works at least to some extent on LINT1/NMIs unlike LINT0
> but didn’t dig deeper to see if it has more issues…
> 
> I’m convinced that an Hyper-V specific structure is the wrong idea for this though...

Thanks for chiming in Mohamed. Indeed, I think the culprit is that
injecting legacy interrupts is currently not working as expected on
MSHV either, so this behaviour is probably related to Microsoft
Hypervisor itself.

When you refer to "cancelling the vCPU exection", I suspect you mean
manipulating the intercept/explicit suspend registers? I understand that
the mshv driver maintainers would prefer not to expose that particular
knob, since the kernel driver maintains some internal suspend state. Thus
the hvcall is blocked from dom0 userspace currently. I'll have to further
clarify that with the mshv team, though.

Mirroring the LINT0/1 fields in a dedicated MsvhApic structure was
motivated by the legacy interrupt injection path not working and thus
breaking the destination on a migration. Assuming we don't have the option
to make it work without a kernel change (in the short term), what
would be your suggestion?

I can image we can short-circuit this chain for mshv, is that
preferable?

pic_irq_request() => apic_accept_pic_intr() => apic_deliver_pic_intr()

best,

magnus
