Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E642282F17
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786799266; cv=none; b=tbrUet4Sim1yebFhop9HfObgZJ97ey45duYq3mBhGTbv0thggeTTxOvNoYZdRlDiQXAwcVrhc4Qec9Ob8S/uuP71brSRCxl7HjqtRU8nsLWgymwNy1/JBJXI9KqVDRN/r/MiSTu8A5/YB/zg0gtqsfuMfVSBd2/9JuzY5R8VJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786799266; c=relaxed/simple;
	bh=0jndbey5Pvjf3v9MX03JkuXQsBTNP/XZ6T3cuUpF9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiB6an9fHqXpllM2RnaiPUXMqzGBoNG0xPRcJDVel+MKBguBFsbHPHnl/L9xPzzic9bDGnCCVQinCNtDXLd9MSLn4gEU44dGO7Ac8jLLNkSedJI9GQuQZQ3WvQPDXu35a5ue0ol5y5XZ1YvnFJ+l2rZX9GoouFakd4ANDcoUkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Ei5dp4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Ei5dp4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956242332dso19940795e9.2
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786799262; x=1787404062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2daFPoDS4/53WEkckbjnmN8AXIA4cD/WTxo7tO7xRQI=;
        b=V3Ei5dp4UCIdByixQtEwEXOY2t2tcdfLjXiWv36qTY8Gj0p2MEM+E50ookIpB+AJC0
         E5HevSVLjjHehj02hG6aKvHTx4tIXZytAJwI/SNeaZkFD60r+7YNQnXrhAR9rLN9XFgl
         OqKG0IxJQZURxWp3a9xplLXkiCZsABGPR0uTnJJWJ0YvxqxJJR3t2E3xjx/UGDrZC0l/
         RpSruO4E8n5O6e3HIrSTHiAU6sve/yOxEjH84FuMFMGqR3uS0ss12yIzIN2WigsNhTpr
         reU7HCld2o8EToQswS52Br4lZbjnH0SZq2BNtl3DorODbngo0nNjvfHRdx0uKqaYS2dC
         By1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786799262; x=1787404062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2daFPoDS4/53WEkckbjnmN8AXIA4cD/WTxo7tO7xRQI=;
        b=hin1G4fGHiF1cUGeF6mbP3sSNmgzDfZEQpk44x0R2B+3rbHZLnuvz50Qd0sPc3pgCb
         /VZCc9zNhXSg/8HQPVg0NWzPq7NSPzTLdMjYDwUIyFl8cLhLMCMFy3o5TcSnW8J2cMih
         zHtrjDU8awcaH0bumx0b3p48vDn/uENYXg05DpgcAnam+HVv69d8gm5b3pswUvaFxTQ5
         PL1ak+olJLxWoBN6tk2XTinMi8PQ1O1ep592QDr4u4FQCZr7IrxloSpcbJKhyna0d7fG
         scMNOxcrGI7ENKStgx8PQLjE1kI0EFsAtgPY7Kqpm518LL/hItZPdmnfXBi/8hxRGcES
         gr+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKs4/2CbRiwKdchCXV8dKtDM2cuNrUZNbJENI47tNHcAD9iBwqr21G7Tou92Gut+sdTcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy195MiQ11/hQbVvjp1BzJLO3XhfXfqh6BP0P4P3rRR8HAHk+mn
	dXIB7Xyr5lnPGZi9KhSGMKXAKpQMqSznYbku5Z6eCM2gf7J+CWm45v2q
X-Gm-Gg: AR+sD118/c3ltc8/dvvZZ7Xm0DGTKLe6xXb6HKme2pIxiRi6AthQNuCPErBGvNJU2Q/
	tinBbsvomUDJhSm0HqWLZcVJTTI2+08BI5/9823oK9X/vtX6ItNQgSihObeur1+NsaGQCozFI5g
	9y7CvovDlegoUe5XeAmzqQaznxuxoBsclwQJN5Q1UDn/S5uV2FP+eNGcUVJZ8UReC9UkHRXHUhn
	YFgzCwUAL6+b6qk6tjPPc8OoB87LfgvNMbCUn+KgaIXMe1HAfBtYu75KcFo0N//pBkr44yv8qZW
	XOwuoKERxgHCglZh20kOz4fLbWhrVPP1IsMKT7GpX8P4FdkWdUkWaUBpnl5m0sYBb62PAuGQgIS
	9sH69VTXLYuN80/ip2cNGMkzcnkZPpAhzSMFpRzQsIADny+lsFDuCGsriuVsCF16afoyLcrFT95
	zJ7juZLYWA4lNm99ma8WrWQW+cV9Kjw9loeDlwIdNJk5UHh9ykne1pHs4+gYDIIWpH/APYjHyV7
	bHG/qAQR4eHjmALGEknhiKa3HFWJM7RXe9GC9eESRIHkGCNAxoUHJ5LNr1LIxaXBiqKxKJ0OP+z
	BsUXya1o5fgD2c2e9cvVCFrTHcUhY9SFxiDwyBF1AzAKVLK8r9eEwhOp8d7VCc39qw==
X-Received: by 2002:a05:600c:3b8f:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-499906ce446mr55403245e9.3.1786799261853;
        Sat, 15 Aug 2026 06:07:41 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d33asm146700145e9.10.2026.08.15.06.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 06:07:40 -0700 (PDT)
Date: Sat, 15 Aug 2026 15:07:38 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: KVM: Fix the GICv5 KVM_IRQ_LINE PPI range
Message-ID: <aoBhU6XIarXxeQYB@gmail.com>
References: <20260815092537.31737-1-kmehltretter@gmail.com>
 <86wltrzm5n.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wltrzm5n.wl-maz@kernel.org>

On Sat, Aug 15, 2026 at 11:57:24AM +0100, Marc Zyngier wrote:
> > +	       in-kernel GICv5: PPI, irq_id between 0 and 63 (incl.), and
> 
> No. Please understand the difference between *implementation* and
> *architecture*.

Got it. That distinction could perhaps be clearer in api.rst, but 0-127
is intentional, not a missed doc update.

> > +      Userspace must query this attribute after initializing the VGIC with
> > +      KVM_DEV_ARM_VGIC_CTRL_INIT.
> > +
> 
> Must? Why? Userspace can perfectly live with ever querying this.

Hah, yes. I meant "if you query this, you must do so after init
to get anything other than zero"

Please consider this patch withdrawn.

Thanks,
Karl
