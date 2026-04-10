Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADD3537D0
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808988; cv=pass; b=o1QLlOX6XzHh5w8dw+nddIkIEvRVTQgROEQCOgEac/NcJaPAmi4NFwIyrLl6MVioEbGo1OXgeDPDRfG7n5dfCtm+QrSQT+9pU6Fz3WPEz5w4dyRoREHm/P6puBFkdxfMHXEIBA+1FsG48C/Gsh4AYOALjEdbC9QC18jv77qNqAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808988; c=relaxed/simple;
	bh=Uvb/4hD/uumcIssiNYPiPXEi2JNTU12p/fbvuNWSK1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUyqVWxHNymAKuRR1nrfdvk7PFnYv9VEg5MdiSUd4bdMb8uWVBW8HAXvAtBF543xv8h4y3bS8cD+kzL+3VeIpKRs/F0hkgN4t1BtmxqHC30Vl8rSlp2g+aB77h+WT55mM8J6nsO2PGBp973zvwSKSq9B8ALJzUgvWoHIHzbnHzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJWoIOtF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByqX6QT9; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJWoIOtF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByqX6QT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775808985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFxM5BL+cfwxEvjP50dB1ug1rShmG56i8K3SCrlwwbQ=;
	b=XJWoIOtFmxG+vylELFybLuFj9BFb5gS93f98V/WL/NoXkSk1E/98cB81fF5p5J3ohPMv/I
	2sDg717iFhYWrcrhGZxmVCA56b8WV6gWYDKmwUsmABi97axT36ZyM0UqVt4535t87gAeeo
	cESP12DZ5mPxqZeDcTpKU6KsuoH3vQc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Ji0Z8mOROzyOkI1u3-zCgA-1; Fri, 10 Apr 2026 04:16:24 -0400
X-MC-Unique: Ji0Z8mOROzyOkI1u3-zCgA-1
X-Mimecast-MFC-AGG-ID: Ji0Z8mOROzyOkI1u3-zCgA_1775808983
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d5651fedaso1724715f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 01:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775808983; cv=none;
        d=google.com; s=arc-20240605;
        b=T8oce/cnhortLUqnojFsk84KKKWF10aiVujG/gnVM96omgX6R7fGWdsrYZAkhJ+w0A
         I9BfoJwKC4/rcqYjP+TJRjkEadovGrp4UqXm4PWmWO62nAJwchVyyWe/EqCOIn/FRwKm
         slbSUEHccN1EYS7m2iIPBWzHAFPHNb6yhm1DnpD4dzfDtKikgTb4JX6R2Pgu/xraxzAU
         yG1uRNLNM83LBMr+NRVL56cjAJwR9BbaKUFtPm0zLRBpZetfH52WAxdobkcXbeiNb7YE
         oWo1B5ThwKOGkxw5xXT0RTKk1rD3gRDymW0zjV3UIB5FoYBeeEnGl9POVkXmbngomsUs
         ADtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZFxM5BL+cfwxEvjP50dB1ug1rShmG56i8K3SCrlwwbQ=;
        fh=uezXiCupsBrza0Xxmpx/J19meSDQO80OHZbPl3koFos=;
        b=lYRmlEcsVI6e/faEiO6NV7DHniuK6KH13DIWzHRD0cIlKcYhwfw+Aap9SgMwHdW9Hg
         EV1RR8/AQg3+EX6LexlQJgM61ezYDjcRgBbLw6U7EZq1RmoO120Ub0nZdcjjv1kYViqu
         D/Ldyu3tf49kkCFPLrtDK6zimUcOsjm0kS87ECwErfBCHIHXzYCw1pfAh6gQUVuTU/ss
         SmW6lL+EncxjQrUnSeCBkNfInn4/HLW6Rmp17rdaUh2xD/HMY0BOrDPKPET4m/h+10IP
         WFbKsFSwcjhY1Obg9ZbcdNbpO8mjKhXt/L34pgNqjZjuZOv0VUjbDYlRukNPeBNrEQ2j
         j+AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775808983; x=1776413783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFxM5BL+cfwxEvjP50dB1ug1rShmG56i8K3SCrlwwbQ=;
        b=ByqX6QT9yacC9LkLuxCtMvgVXEYkGrtnlrhAVv9gSnJsHZLVH/K4Ce3Ikvip0dIx3D
         tC9188kozbBQ3d9PSfwxxF1J1R1kP0R/jRoA+AkBQ7ZXTyppcs1KzsXYZYjrp+IL1eBn
         zpBlxsGojoUDbJiuNz1wb6rAwNrI7ghkwccsz/x+adlLHHePYf9VTRnZjl19ByysrohI
         +J3OGqd7iMZujeuJfOjzNKAVLFZMYzJSTBJMrIHFmh+3ruLimAi7bakTAmwOmU2rlvrF
         o11dpxcdDOKRg7cUm0RB/oX7Q+f+jKdletGvcIA8m0vx1AxV96Q3eXXp6JuyyAAWG8bp
         hRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808983; x=1776413783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFxM5BL+cfwxEvjP50dB1ug1rShmG56i8K3SCrlwwbQ=;
        b=XvPD8NidIHQ4BPH+Xe3G3CvwJwMLmsNRosXuGAXSdcXW4h8EhGQB1u7xcsKfCPtVSH
         KTuHxlJgpzwhzuWpWyUgzrhc2QqsZOiR3tu+eL49kMR1m4otdlZOfKH1QYdFkhhoiYec
         Ef+jauWy2IJs/6xEfuNu0L/9TJ2iyNNb6AqfzWF69ZQ63dYD14m4JtYYGfUsoISX/Yr+
         7qp3tsfEveSTd6CnQsWOoc/yGt5CB2A9n0Lo631D0Bmal90l1O5NAF12oqIb1T+B0pkF
         1YhhEXzti4QiJVj6kTg75GHFmGz0WPGEfxS0x2swKg7RnZKM9zVI9TBrFWWFrljQ0KGv
         R9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXmE1yvvVkkm2qTY/F3SGWqZM4Q6ui6ez8th/wcRZRoSCCdz2ZJi3Fy6ReG4R5uNEmO/pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwburSfrmtcQpv5U1Cv8RT8TaAvdAz/FOVGUACBhsq1ZxVznUkV
	hMiBp159sqJ4layN7WFTAFCgRUJS4bWeCJ/EXhb6d6vvUUYa6hg9v9COrng2sNPO8kLQi12xDBw
	jIn7YrJ+r2T1yjSeNZXEsyZNuYg7tA4CaKOo10CLMYvLQKUKyPTLBZHe0MQqaVHck2rlcLvc6MW
	JRWEpyPnUo7e8poL0yVPiqia7T95JF
X-Gm-Gg: AeBDiet3wQywE54fZ2ggSJORahm1rw5/XZcOD8zy6DqZWzyYGGXNWmxK4Bw3ToN5H8D
	lGSDJOTwaqpwjeb55zg5/QNIRzM1PKNEF+a/+gqbj8yuN5lf3vvHg04HE9HaPactNbWhcR/z+oE
	meyBnq88JfG1Vp3VcrIlCr2Oh7TAx8Z/T/P1mvPnXDibDYCqVsIAGYAD4DIfs4Havxw+Ym2Re0i
	QwSzMCfDuiw0bqIEwmNeQ2YU78dFmW+ZC8CjbQTFdsbuFmVrx8K7LhWAAN2PuYw8r/lcxguffw4
	1Ad6
X-Received: by 2002:a05:6000:230a:b0:43b:6a55:e26a with SMTP id ffacd0b85a97d-43d642dd77fmr3088537f8f.51.1775808983186;
        Fri, 10 Apr 2026 01:16:23 -0700 (PDT)
X-Received: by 2002:a05:6000:230a:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43d642dd77fmr3088498f8f.51.1775808982763; Fri, 10 Apr 2026
 01:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com>
In-Reply-To: <adf29Rn7q9Db0hxc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Apr 2026 10:16:09 +0200
X-Gm-Features: AQROBzB7gHV5kpkdqHhJJkL8n0BUhACw1Hif9GQO7THtYSZF3eeaQ5iOJIpyDlo
Message-ID: <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Il gio 9 apr 2026, 20:59 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Apr 07, 2026, Paolo Bonzini wrote:
> > VFIO is implicitly taking a reference to the KVM module between
> > vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> > symbol_get and symbol_put.
> >
> > In preparation for removing symbol_get and symbol_put themselves
> > from VFIO, actually store a pointer to the KVM module and use
> > module_get()/module_put() to keep KVM alive.
>
> NAK?  :-)
>
> I really don't think we should do this.  We're reinventing the wheel, and probably
> doing so poorly.  As Jason suggested, the proper way to handle this is to pass
> a "struct file" so that e.g. fops_get() pins kvm.ko for us.

We could get rid of the reference count completely (get_file() as a
replacement for kvm_get_kvm(), get_file_active() as a replacement for
kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
struct kvm to struct file, therefore adding and removing a reference
count would have some additional pointer chasing. KVM has too many
kinds of files to seriously consider passing around struct file* in
virt/kvm/ and arch/*/kvm/, and you'd also have pointer chasing to get
filp->private_data so it wouldn't win much.

Passing both struct kvm and struct file, instead, would be worse
conceptually than this patch (because VFIO doesn't really care about
the fops as opposed to the module) and uglier:
- you can introduce a back pointer to struct kvm
- you can change all struct kvm_device_ops implementations to receive
a struct file*

While I can look at using the file reference for struct kvm, I'm not
sure it's a win overall.

Paolo

>
> https://lore.kernel.org/all/20231203140756.GI1489931@ziepe.ca
>
>

