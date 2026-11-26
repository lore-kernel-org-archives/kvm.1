Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701889;
	b=HEYH6P8oP3In+s2PSfv40qkWnZkntL42RvC3tRd39jIIVbTO/VHMpyz55k+DnQ70MX4t
	 B1ilcjJDoZDSdvmioGHmjj8Po5HeyWBHs29Jcp/X35zbSE1/2DcJ2WKfI4TNgKMQ7Ebxj
	 NSA3dGrKP0KOViM16/h+7ZxnX6RIl0rXiEIubFiBQrM3Pv2NhKGTcwvMm3gQxOwQmM5pT
	 GzK4m8BfsoyGjx1ZAQGWZ0XDUHWDONhQFn9aJchzNoBP5lDedXrfsK3SQLNflhnx+W60X
	 PP1oqef9nrnz4RCV/PxBUZD8euQqzvnErQHwkpFPOi0Txp80gF9gjXSiJdCNoYpnXkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
	b=vdNQ1IyAGztcnIhWLHdCyYEmAYpKTO5K/70PcvuBTHiOZSomRcFJ55yLTiB8wJLCZh2e
	 frn9B6sjRFxuPqniUMoxRqOZ9g9O7A8FiVMRRs4q7XxpsjYJlWedZdPkbM9eiZZL6Fbaa
	 iyZT66pgbmicskcMYR+7AgW287NOxdy9lqPtbMoAbza3wk+25MamTpzq/KCFnt39YAomc
	 hrmtoGDQ/YJZuxQDmjr3A2UpDKZVbNbpKWp2syPmiNh6lHx+aHusuTqxQOWnIamG8jI2z
	 obUxw3I6vOkT4yVNAmsFuhJyFRgLRBLEfvjWs3pN9V86/PiiqiGbSB88i9WLGrkeqDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ADXVoqPT;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BD606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ADXVoqPT
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so66341685e9.2
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795701888; x=1796306688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
        b=ADXVoqPTS7f2hhsnwR3CfjDkbVY+bg+RLlNZcU6eV9k9hgeSl+Q7T9M20LufkZ7KoK
         a+3sSfQKhEtv3dcZxLtrwgCzz3pC51SvgoYRDTXGK/249wuq+QUL0XSYDGm9SKiAuFdF
         xPjktJNSOB6Lrt43/g+wE3cqskASEowN+2zbdXCmD4oivLbfJRaUE9knaa5dbe890i6v
         10ghwsXMMrJ76SjF7yTcDBZ8sWHawBtmMI30JAZd2s9tOgmbiqPH+xn2EXDSfWNwh/W8
         TzFrmIXm905c9MO9oWsMnANrmHi6oM1PV5zRF5LcFSt1RO3GztJYNNAM/9t1uC/NYep7
         TR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701888; x=1796306688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULOdJrhzU/wAffNTY82qW4SO373n9wxqM9z/O7l2caA=;
        b=jWldDnC8mFuAtRrjsPjpGZFlohebluax+g+MPKh403ibGu2qxfY7yMO+sd6Sw3OeVs
         lZPe1gFLdXMMNusGzkMuytnP+e5AFCnCdlTbzCoWRCEou74tS6AdsOU8qa4DQ6lueQNZ
         7gCR9zz1zcDMNRbecGslrudZPlTtRwZnDNMepvP7R1UxOLgPbwZ1j/NzVF5NhFWa7RGb
         jj6Jf/F+PWbekBhY+F6Ut5snX2TpHtHQHA53THQhBfGOj42rZJU/ErBXsq0wP7TToxzj
         g4iKgBaJCgphmSsYyaVzwaW74a9syybY9W4aB6nGC3skgyZzhFo9MfRONbMdysEe2jdB
         3ZUg==
X-Forwarded-Encrypted: i=1; AL+hErGximS+bI5j/S8H+EjLxMrn+zjEVkNqZk68kvDAFxXrbkwkR3GY4KScMeJ7rvk8RV9nlfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RyGMOXv3p3mUBRnZ9LND6y5jN1ZF7vgHZ2MHpn9jDViodBUiK
	JEZJNZJ6iQaium48dco+h0ctpPjKemo8E/W2hf/jA2af6JyONZUSbW5VodZuWsNb7Ww=
X-Gm-Gg: AZFdTZc2lu4zld2GIP+gU7g7MEuNxd53rUZHH/rbg/YnD9/mt0ziSXLVlpluE89VrG+
	ggIGgpLYAzKo8iXIHSPurmj+8MxX1UAIsZoFbbV5KO8oHhXh4QpFOtSzAMKBMBT1u2O6TEw+sxw
	UC20C9qGdTmcY/qXu+SQcWrvWPQvzufDwZEBhW+8GzpngtzxPLTLfRTf2jbWPuLgumzCRcyVzrY
	kWoeO5DzEWoN9AFe4CQihVy3Y0WiCzJDfba1nrFhhdsgk6R1mW+gM8WXRChph/deh7HQ8vgotrM
	2Cac7RF7sKp6pZPvPKqk/lOPhN3Av6+LP95CdPnSxuEbMZxIL2OD9J5xa3W1l9mZeKkJRKIVEIP
	SpMQ01zmSFmxBCTYmZSxlvU56AO0OAqbIRIxKQ+aSW0ZSkc/2fiZBylZf/GeAj3K/iKCOP9EXti
	Rr2vnTUAGOb/HCmXoCoCuAz4juwawW8XWT5jLNyi7fPjfu8PKjogID2ZCv9xs/EtD8ZcdvgkYFs
	bn9KnQPB9L2dB1k9td+LbMs7LQDzIIEOZdoQoTI8hKlqF/YFDxcQvtDSQFWfo0EW+WmC64Kp6Dt
	oIrieSMFQooJ5qwaZpxnQBwH+wGCeS5OliY9Otj9
X-Received: by 2002:a05:600c:8b83:b0:4bb:60da:56af with SMTP id 5b1f17b1804b1-4bb8893053dmr381871055e9.25.1795701887195;
        Thu, 26 Nov 2026 06:04:47 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm736831665e9.6.2026.11.26.06.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:04:46 -0800 (PST)
Date: Thu, 26 Nov 2026 17:04:43 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>, linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awg8e0zM2DL87AKP@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
 <awam4std0Zifdn9k@stanley.mountain>
 <awan8mSx5cbzXzJ7@stanley.mountain>
 <20261126133744.219929-A-seiden@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126133744.219929-A-seiden@linux.ibm.com>

On Thu, Nov 26, 2026 at 02:37:44PM +0100, Steffen Eiden wrote:
> On Wed, Nov 25, 2026 at 12:18:42PM +0300, Dan Carpenter wrote:
> > On Wed, Nov 25, 2026 at 12:14:10PM +0300, Dan Carpenter wrote:
> > > Let me add the s390 maintainers to the CC list.
> > > 
> > > I considered doing it the way Sashiko suggests but s390 doesn't have the
> > > __vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
> > > not the same so, either way, some of this is going to be specific to
> > > arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
> > > across a reset.  The s390 maintainers could probably take the selftest in
> > > patch 8 and modify it for s390.  :)
> > > 
> 
> FYI: the arm on s390 KVM in the current upstream state has no idea what
> SP_EL1 is :) 
> 
> > 
> > Actually, never mind.  This can be done in kvm_reset_vcpu_core() like
> > Suzuki Poulose suggests.
> >
> 
> We share kvm_reset_vcpu_core() as well :) 
> 

Yes, Suzuki Poulose told me about kvm_reset_vcpu_core().  If I put it there
then I don't need __vcpu_assign_sys_reg().  Thanks, though!

regards,
dan carpenter

