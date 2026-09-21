Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0B45FFAB
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985422; cv=pass; b=DzmH2gyzch4cPJmjrMCgYo6y4ZxiD6KcP2/rkDXLiC+7u7TfG08QaebnklNP5yxue5rJJmeREx3NT+/2FSbu07ZI8bWoKOwovgAN1rLFbAN7lLirbJUG6uixTAi+XQ81EJdhcumVQzIYmRd9d2MW89WfSAPdcNh/LJ9DLlKTZ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985422; c=relaxed/simple;
	bh=v0P4ayQReWgnEDJQOUIqGqH/JIvX4Upl7U9Sz/eEyJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCR/+mj2XNXuT86duBOwy3dP8wXM2KgpSPFWVIJxynwZr6nSmN+wwp4YHyixZVG7Kpxk4KckCQvOTdkkSZo/WeFPAoT9gfiZFYdZSnaCl3rzWnEE+jZjA/wBeqqGmF907SnLFP+J3EWNG9vL/cSI6t2vtlArAiMXzDedjV5YPDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blkNCYFd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpOBrAd3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blkNCYFd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpOBrAd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789985419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YA3vQgRKFGawP1ePJiuBgfbEVZaFG6kWjdLmIbJG/cc=;
	b=blkNCYFdMHalfSbLwbxVpp/ZB+SssmgNqGCcnE3yDOYkhfXFRCa2uxxGBtkYSSqfwM6zHi
	/W3ha2c6YNxy8+1lbj+3lCAJ7r7vE+QZy1sDI/+kEV8T8OoISFLoGwLcHpmBDKJ0XbFLBx
	YJ1pgoM3FG2xMcSsp9/gZi1NQZ46kQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-TJCLf19oPge6aASFrubvGA-1; Mon, 21 Sep 2026 06:10:18 -0400
X-MC-Unique: TJCLf19oPge6aASFrubvGA-1
X-Mimecast-MFC-AGG-ID: TJCLf19oPge6aASFrubvGA_1789985417
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e82768ac2so19434465e9.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 03:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789985417; cv=none;
        d=google.com; s=arc-20260327;
        b=Oz99DSGeGgm+8D8219UaXEE0olHgPv4g93ZnSGlSmgdk/XG8qsUpt7+E1At21CIbo7
         UEzUEbUITQy5HUTb6+HH9wjpjLq2/uJ2EJzFCOIVmK83V+KVfWAzCj2Hbu7XxvvIyHuA
         oFQEFjCtqIT5vDdU86FDocyJWiGGu0puL4xstI8H2zfhiVblFF4mIVbTMCCZVnYYeVah
         WyTdZwK29vKQIaQxz/RNJMHPT2+OZAD7dIz8FekbYlZpEiRPdK1AYquLPRLwKfJnsseg
         /85JQrFk0ryM3AVPyS7EsnQzf71QCdPYsScPQQSYCjmZuC/qGr/08Vpuq7IXQ/8M529S
         C7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YA3vQgRKFGawP1ePJiuBgfbEVZaFG6kWjdLmIbJG/cc=;
        fh=t8eZ0aMK6hpJvZrp8eK+8tlpRDdHqse0UZMQqzHrM7A=;
        b=G5MUz9MgkNvOavBCAYqygLiYPV68D4BTpo+vp3NnuGz/Vax0kVqIKvJf909xSNw7Df
         QZY4SEgZdIUYRDRlogJtIlBMuEjl3VBsUoWKTyGniBDS9F9Kyt7xb1GMm/8Cf0rzQjl3
         IxZhpXmK47MBVOARbIIS3N1cbf3zfzGlKP0WF6QBcj98FaT22n/J8oKpFAaXI+jqemYI
         +D8YW2qZBP7aaW65E1BIOBWxA59JdWbX4zij2co0OzSgp6Y4Y6uEnP47vMcBo6NQ4Hae
         em6GXpCaR3lWAMgny/33540uRsppJIv9vJDW0suh71cQbqbwE7LhaVEFPmtyr2OTfXPg
         4Ktw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789985417; x=1790590217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YA3vQgRKFGawP1ePJiuBgfbEVZaFG6kWjdLmIbJG/cc=;
        b=bpOBrAd3ZiKKPuf+HcSc5GQXPrs7K7bWH3khTt+MKWbrmW/s6U1iJDOzH4chqDQbxN
         xsb9wqS8scizTsEPhB71R/NA7gI1LOUaZn2yDUFNVSI72hSTpVNeQjYTjRWfGefV5zI9
         0abrnCyNaPmgJPvBmOhfUzcdYg1bt1pPd1vgYtLw2OAo8AAa0ih2JywjuaOTQTuA4kO+
         Gqpl+2oEyjpztHmDvbs/PnuNibwCgPZXdK5ALi1UK1a2xzaPG8oS3YN/Jluvuk+klgkj
         Yd5ZMD4TOao5Q9XgXCQK21vWmxYiDpMgHMUvFxnUYFga1KQhhbL1XWi2SdFtAcib21pr
         N2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789985417; x=1790590217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YA3vQgRKFGawP1ePJiuBgfbEVZaFG6kWjdLmIbJG/cc=;
        b=r0WsHYLISR2ldptuZsLxh5SZubUJiyrhDqoItDyk7S2Lzg02Z/0lJV5zMKbkaLPSbB
         IU8HvJmjAogZsjBzTQ4Dyv74p4hucoMJR3PStYbs4oLWyMg9TqL3VGehYrDdY8fDd6u9
         O9BrdJT3qMDq2shrn0HNYCSf7CYm2vR/cpV1OOb/+vZne/XvQ0Jacld0YVyp6kCHDP1g
         48xEM0132vmwph01tUXSt/4DapkoYXRt4ld8ScHV0fJU210TTcSW8O2m0z7FRU5+D4m0
         obzdfmmGcXdZRFF1Tm1PUHZgWBWHzvIyX43VhdEeMLgUNIE22sIwbKSS8RgasyhUK2aT
         p2fg==
X-Forwarded-Encrypted: i=1; AKwUvBxD75eN1JlzyXc51sbvWKKFlu31NmlvDRAwT8BRfs1POHeFHjp127fCVjfqi/cf5joqw5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nRvb3OfcvRZpL2jvGlPY28NwTQ/d+4cQIMeU+/Z0eUuG1eExlr
	BBcr4b1l8lvGPppfDFtGAy43V8YLghcV7ySom/+bsZz8Ukh8LbVsOcfppO6a4gognUvubkJOm5G
	DMOYSIKrSamuAVTaGWqHClPHHimW0ofREu5f24Ko7lth45i6hpkiwvO6XoR+uRtfyzHIQi3NiCb
	5QWTGT8LpP+LrSsFZkTK6m76v+Zfli
X-Gm-Gg: AYBFou0xEgYT95G/ZmcstwlJbEcrhfGswYcuxnirL2YhM8oNg0nL7+M/p1wA+kDynTL
	78AgqNa2VREixarRuKcmqOdo+KoI6rwrTFT1lEJfPVKag3zlvtJESFquoJNBaxC284jeet1CNZr
	t7ZNDJIgZ1VoxGf0XVuT1A2J5s1Q/IwZ1vM0rEIIfABzA3/MlN5tUPwq5ODJCMniVDnq9nBzVI/
	LVm2SB6zdl9cGNhS9X9k/O0q6RVYYio3vya2Vs6EI92dS/YTIpvGqlnCP8cfQ==
X-Received: by 2002:a05:600c:37c3:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fc4f8528cmr144125055e9.4.1789985416922;
        Mon, 21 Sep 2026 03:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fc4f8528cmr144124745e9.4.1789985416539; Mon, 21 Sep 2026
 03:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aq7ViMljbhjibseX@kernel.org> <aq7WIW052XXHJWlL@kernel.org>
In-Reply-To: <aq7WIW052XXHJWlL@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 12:10:04 +0200
X-Gm-Features: AcwNN1XAAsJ94cGxHRMtNqiGnGs3RDz6T6V8oXiFTADje5gE4RX36YH8CZ6l8Ic
Message-ID: <CABgObfZYa8uwsAgKnr6952qMZf6jjf_AsJBmxeS8zYLLRSGD_g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.3, round #1
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Sean Christopherson <seanjc@google.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 8:36=E2=80=AFPM Oliver Upton <oupton@kernel.org> wr=
ote:
>
> On Sat, Sep 19, 2026 at 11:33:45AM -0700, Oliver Upton wrote:
> > Hi Paolo,
> >
> > Here's the first pile of fixes for 7.3.
> >
> > The diff is definitely on the larger end, although this is mostly
> > explained by the inclusion of a selftest for the ITS table changes
> > which are quite tricky. Also worth noting that this selftest mixed poor=
ly
> > in next with Sean's PPC selftest prefix due to the library changes [*].
> >
> > Otherwise, the most noteworthy change here is definitely the pKVM patch=
es
> > to unmap the EL2 hypervisor's stack pages from the host, for obvious
> > reasons...
> >
> > Details on the rest of it can be found in the tag. Please expect at
> > least one more pull for 7.3, there's some additional changes that are
> > still brewing.
> >
> > Please pull.
>
> Haven't caffeinated enough yet.
>
> Just in case it wasn't clear, this is a
> conflict with 7.4 material and based on the conversation I expect Sean
> to work around it.

Yep, one of us will handle it.  Pulled now, thanks and sorry for missing rc=
4!

Paolo

