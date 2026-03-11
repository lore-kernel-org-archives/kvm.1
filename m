Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875836C0A8
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248757; cv=pass; b=ru1Ma5iR+vSxLAbEEbT8TtCXTlHL+icar6KbbGwtxQ533sx5EViT4LpkY/UDuN+Lv96a/mjObpOAO5adghq1tv+5UM0zcJiBzBQhb9smUnF8UCLHqXrt6dNuV6iz1HRLhnRnbtfcRQt/MQAAB56IOvCukaRlLAYR9NXGO3l1oH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248757; c=relaxed/simple;
	bh=vj2yvLGgVITiiLRf6REAXbXzj8fNSDCMYaahdwZynlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAIzXo7suXCozNdB9ESKCuZfljHEXthi/IJyLCT1AhykvdkAWYJD/g9itGxMviIfcW+tqhMlBU2Khj/3WmV8+b1heFG4YfRMIIyXnGf1EuG4ZnA4Uhwla9/Ep6wc2lS8qqE4dSr9Sl7niJ/BzLqKx2QQ5BhxTMw78BiZzul/9Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py6ZEAQe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQAnAS/5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py6ZEAQe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQAnAS/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773248754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vj2yvLGgVITiiLRf6REAXbXzj8fNSDCMYaahdwZynlE=;
	b=Py6ZEAQev73lHrSrmwUe4Rj7ld47pk/SKapv6vi23eVMTj9tnixkIJbeyfUCj2evFOXWie
	ScJ9p+v11EAjVR4rBwdkFPSD8T7Qcl6+oWSZAcXNQ+kJUUBf7EAHZ/TH86pS5DSVe1ovGG
	uhf0hIBz5NItEe5EZCEn3QU7Vw/kJhY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Fse-l3D4PmS9PGxiR2MV4g-1; Wed, 11 Mar 2026 13:05:53 -0400
X-MC-Unique: Fse-l3D4PmS9PGxiR2MV4g-1
X-Mimecast-MFC-AGG-ID: Fse-l3D4PmS9PGxiR2MV4g_1773248752
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c2a0d821so66201f8f.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248752; cv=none;
        d=google.com; s=arc-20240605;
        b=PYRLwBTuEuvmbsFqp8A5WU6smmT1xkJFx7qnUqCWhG/Y88v4wC+xcZEpqagrrAtt8t
         STD/tLkbXq6OQrvmCcB4XQ9GnvTR13jR2Og6jdiYmdMtox2s6q46cqhd5utqvfyNGetd
         8WM7xUC4fgrPv2QP2bITQcvdMm0wOGbAk4rnHVKu6lAhl4UDrpMfm8A7jukkYQZnU4Bj
         slX4t88Cd/fNciHC4m8X/Efk8dAQaNzVbGnGjxSzh+dUzqibk2RlA7Wm8ebJCrk9Pkpf
         qIHDdeFg2NCvhvAuz6VdEuSMOG4oO/0RZp/4e5ZrdiGucH5VBlhiLykNg5Rg3T2ORSda
         vDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vj2yvLGgVITiiLRf6REAXbXzj8fNSDCMYaahdwZynlE=;
        fh=SFxrQuS7GnvJArCY3JVxNzX77PBEB/HzgWAraD85c14=;
        b=lt9mOgxhU5nBVyfUy+awITyrFqg+S87mr12s72p20tywSmRNcM5bMtQ2OnjukPF3gq
         boOVumtGXn5/qsxO1knXoFw526/VTQaFAibzJZElwepZ/HRxhNycOBD4444KZ6sTzZS2
         pS0rGXeZHWNYgJHted7XgR2BnlOBbzF6CRwl1IkKExeAQLIHDh2xKzGo4zFm1Mv+pVQq
         V6NWCY3CGmqphSWtU9sVHG8g/KIo6kwvq5efUY0dnGKCqsIWU2zLEl84xZUDsZZ/sZ9s
         No7GVWgcaQk0NyeMYgazCZusWPW6FtHl7Zehn62yB06EM+F4Gz+n5Bx8/5Kcit86Q9Ok
         BLLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773248752; x=1773853552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj2yvLGgVITiiLRf6REAXbXzj8fNSDCMYaahdwZynlE=;
        b=eQAnAS/5c/0uTDo/cH6V42dV9aAVZ0MtUVp7aWZjYCWFT/J93TLaPLWolV1hnbO67t
         ECeZ8qQBaAPENF5XCeXjUKhBsrX/vzE3AIX9+vSpPrNDXZk7jIa0K3RqHubwkjHFaR3p
         tF1FeIvYbxzp2iEkLUJ5WVDaZJzDYLxW5PapmPlngzE2VZICvggoDVI5uxsFFFcD9bJe
         VXZPc9FMCgVXWk41nOAGIVLpHWSTDOakTKuEo0zrYCGJj+rGPNBPxLeFe5W+/tVRSVhu
         U4Kl9Ih8jQqZXdtyaM6Lhi6B1I1uNveGLw4YnyW3PABFQsjUjGeem2OqF+4egq5TzO0F
         3h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248752; x=1773853552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vj2yvLGgVITiiLRf6REAXbXzj8fNSDCMYaahdwZynlE=;
        b=Bsy+TBV0bbP55Hov4yT2GMAN5G12ZeqXuRzwtbkTjhB0OI+Zv5OdYnxua6QpLccVRI
         K/I8ugJFoxdh698hnjkYsasqR5FOEKSyeI8DJaScGVS6OQjgRNKwwdkXW55Xr2kgDe/q
         6DkYDOmx3zn/47fofDn80dU0metffBVo4Oraj4k6FZU0QSDiHNSF14MTNAK63TALXQJ4
         z0Kl22C5qnp+xEymRwL/TFeHgl5OxYb6/G+ijIyMyN/ECIYkwN2LJXW25TSD2RbiY0pm
         ukSfJJTO9lrw/n31thCAs7nBxvgqu0kv3WnzKDqVDKcNSw/SQdd3RbXSW9hXDs2HPhGP
         xA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUylS9Z23MUIzP8+6R6rv6JS+pnLinsVpAGbMmNob+e+xEysvQqYX/3iqXtGhW6qfCK55Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIe3slbGcEB/OL3gw5S4IZ5+xfxpjbMSMqWTre+Nh5d4xv0VvU
	eYkY4v9S/iY+v8bnqgD8p+FVAHMDY5WNOEamEn1C1XcRr3VMEwSCXOHSnDVfKd5vbqHwFGUF4Ok
	qrC0YpkxUTTA7x97+92fCaPg9q29ItieTstzIbiA2T85C/beAUS9e8HEO1yQpJ1h8fno4flDwUS
	n6QMlNE50iPD140yToEFP5TMoB/U4z
X-Gm-Gg: ATEYQzxZ+/9zdJID4KVHwkE9A2IKN0kArr6oMdIjdN2DXNyqXjuQzWixOqtab7U5Z7m
	NBKzk278ph3hxaFOvX8DPn7lZlqB89URmPE56GKQ46K2F/dMeZP4CDAH87w0mSSG1Kv2enMQf+X
	GKtVmJxAbEFNQdwcq9YgcsGIKRnFfwtL76kbyEm4TzQyKsyk9xpquMC7zpcKqvXu8Afb9469n3S
	XsUj1z7/037Kx2kdbSkxZI3lUEd6JFs+RvVR6wK47Ngvs0wo4zwmx598VFOolg9gPakOJaGLXoN
	pj5H9cc=
X-Received: by 2002:a5d:5886:0:b0:439:b6f7:7ed9 with SMTP id ffacd0b85a97d-439f81df2a4mr6786234f8f.10.1773248752119;
        Wed, 11 Mar 2026 10:05:52 -0700 (PDT)
X-Received: by 2002:a5d:5886:0:b0:439:b6f7:7ed9 with SMTP id
 ffacd0b85a97d-439f81df2a4mr6786166f8f.10.1773248751678; Wed, 11 Mar 2026
 10:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306112231.3201502-1-maz@kernel.org> <CABgObfYJqhj3xiM4_+7gCE1x5v5JQhyS0ox4+obrsZwA2W4GYg@mail.gmail.com>
 <867bri70xo.wl-maz@kernel.org>
In-Reply-To: <867bri70xo.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:05:40 +0100
X-Gm-Features: AaiRm505BH0B-LgEHk7B9nd4GEA3WrtXkbmONvErj4A6FWFc5cpbN4e0xfK46wI
Message-ID: <CABgObfYjQaTiC7ng3rY1FveMqgzgWvKk1ER6rymfbWNSo74jtQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.0, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Quentin Perret <qperret@google.com>, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:04=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
> As a heads up, I'm about to send another one with a couple of annoying
> fixes, either today or tomorrow morning. Would be great if you could
> stash that one as well.

Thanks for the notice, I will wait and send everything together.


Paolo

