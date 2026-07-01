Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249E48C8AC
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919825; cv=none; b=iBH3W53YzzNBDayx7ec2fr3ar91SHr2M3jn2ZHGSck1S+ahizQHijgsVWfLKTw2gEdTP4LkmLiuVSGcLWcBsPRKqDa00rShWVYsiHz8cdiUnp02sd6MUNwtsk2k9OKiqczRLOYwPqdMW3OCHvC/gKYdZ78UzezYo54+K5mmttjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919825; c=relaxed/simple;
	bh=qobMLAwTmpjHDZTx8NKu09d3JezyDm5PjHsYRtwRUNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptRYF57mdhjNklLUql7v5nkLTMgi5ZHzG4e/SRZYUPjCAfMu8KmAulNnInIMnFe0b4Ikd0r6A/YcidK/MWTYXk35CMrYonlTrJ+UYpOlo9YAOg2jBCxXgsWJUbDtprOq7XfCaMIcPF2O25JfX7RRBnTSFxVxSGbL7ChvJ56TOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xoj8ppFI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xoj8ppFI"
Received: from example.com (unknown [167.220.208.73])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD0BC20B7166;
	Wed,  1 Jul 2026 08:30:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD0BC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782919820;
	bh=HWPrvAn7EFe4ZnZmgq/RGK7Brh0+CpGD2KIlAvcJrEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xoj8ppFISXUIsK62XSbTpm0YiH5nq/muNly1+6Q9Mf7/wLXJj/xzu0IVI+qTBdqBd
	 /7154wseo4VJ6BFJlJ5n0Jncsok0wgMDj4rm1LkAt4osunknuYuXwRCbI7JRmksysv
	 SSjAUTDFCrolwI9tVDWC5ebJ+8aDUMHBARXYmqB0=
Date: Wed, 1 Jul 2026 17:30:16 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
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
Message-ID: <akUyiNahX3LnFPhn@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>

On Fri, Jun 26, 2026 at 09:27:20AM +0200, Paolo Bonzini wrote:
> Il ven 17 apr 2026, 12:57 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > +#ifdef CONFIG_MSHV
> 
> + VMSTATE_BUFFER(hv_lapic_state, APICCommonState),
> 
> +#endif
> 
> 
> This breaks migration across releases for everyone else, and also across
> builds that have different --enable-mshv. Compile-time defines are almost
> always wrong in VMState definitions.
> 
>      DeviceState *vapic;
> >      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
> >      uint32_t extended_log_dest;
> > +
> > +#ifdef CONFIG_MSHV
> > +    uint8_t hv_lapic_state[sizeof(struct
> > hv_local_interrupt_controller_state)];
> > +#endif
> >
> 
> No, this is called common for a reason. You need to implement a subclass
> and handle migration in there.
> 

makes sense. I think I found a way to put the additional fields into a
subclass. the apic_id is semantic, so we cannot use the auto-wiring
dc->vmds state, but APIC_COMMON is doing the same. I'll send a revised patch
soon.

thanks,

magnus
