Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232B46C4C1
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649773; cv=pass; b=IPk4d8km/hVB57DAxHtjw1LpRHnnMm5Uos6yufgBPXpTZ6baM50ZTQ/OzVuEiuHFG1HDrl4FuuaNw734TSsp0/I/PTrk5dyiBQfffZrV4JDS1Ekzhm5oKDMU0u6dLKRPVJN+bV9F9vM8UQnrE4WTaxo/4caKZbp71n6xWqixELI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649773; c=relaxed/simple;
	bh=feRZ4QKSvrkCWAWS59c5Jn+FQo1zqyY8SL/+SCIGU2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeOTsrPKxHgB4a06MXcPsTTO0MowT2mdCGi2KQNQ/7serH5XnUCKy+kXZk8LnCAexkzd24fHOFDz3YIPhUqgUsRvBiT5KTBf3KHiamSeKt7I6GY6UyjvzoiI9hZ16nzvju668HC0FJg6ms4aq4RvVXFOF4Ji7P1h0Dxn+MTS23U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IK9Odsxu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1QvIWXx; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK9Odsxu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1QvIWXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784649771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STnbg2Xg1zNCMraSp4HmfOF93WxrXN106QbVgR4DyVw=;
	b=IK9Odsxu85JF7dWil66ypDSwLYDZm0Om4ZITBMA5V8hiOhwrRTrGqI62JUSLPK780KTSbR
	XYRO/cRBvvrU8nNWU7JrjVa30v8yPORuiDbuID/P7e+kSzrsDGUjAFZaf+RRVCjSJYaBXs
	y7jeGCk8BXy/Mt5F2dm5dLQN4J7gvpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-E2L3mCF3O5G5bl5f6KItIg-1; Tue, 21 Jul 2026 12:02:49 -0400
X-MC-Unique: E2L3mCF3O5G5bl5f6KItIg-1
X-Mimecast-MFC-AGG-ID: E2L3mCF3O5G5bl5f6KItIg_1784649769
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso90539535e9.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784649768; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3hSKT6Ukv2+Wf5yFntFYWADdIbb5ZfxlgT/TvtDgdgOFDJfSb5cChoxTvxx5zP4+N
         Hixqog41JHwLgjot/pEuOC7VTMAPcnNvmc/WmdETACYpBaNSutpPWQnZ8Eactwuc6/hN
         9SqBrqCaByXBcQSET4w65wIFHBOH35Y6LsHasIvg2Nli4C+m/B71IZSmxIp6M/wGUVZy
         1pu2T5J76MzJZNMKO1rgsv3RWk09wYltC8upphB4vcQP1aeoT+2EGyfO/WbupX+Z1RY2
         FX2kNaZGCHuC4RG/MyQzapxmDqV7c0VkGKIZlaGXY35q315kUCLlRRyA9H3CNFbpzLCi
         9lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STnbg2Xg1zNCMraSp4HmfOF93WxrXN106QbVgR4DyVw=;
        fh=8yrak1Tp1Yavh400iospK+aLRJaE+dPrHYRk6PwrSBo=;
        b=K3kX77AIgl/9JSZms26Q6NsHhatjYGaR33maxXltD6TViBhScMFyVhEWl26ZT9EZPf
         pF2f9gAvkUdRdv1JUY9DPUU91inTYbX7G6ZAQU7I/DOuSNd2g57yRQw38IE6Yz4Dj8Qj
         idj9hkyrL0FRKKdcfXY4sr2dyGbpqH51cUuQ2gd23p2/SFYcKLSHrXArj0IcQE+//1hI
         JkTdsN8I7ChOFvkw2W86sTuB9Sebg40xCu/EuSX1vMgCkQ2078anvrmqYwR2cLq0uhyM
         DuSC8T2VC9kvF+LSON7TDiCFeB3hCHWhcB9/lvb6RbdZwWaQRcZ0kLSK2Kx6UncaWURk
         RC3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784649768; x=1785254568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STnbg2Xg1zNCMraSp4HmfOF93WxrXN106QbVgR4DyVw=;
        b=X1QvIWXxDZ+C8tGU1ThFpbnNXgx3z1ERwcEN9EJgDH3ppm6TZfbgdLML6nI1/HjjY8
         H7f7Go6AloAjZ0MLnBe7KIMQzHmGIoCWHqzd2g4PJo1tdeRX6fv1wVXUnkXENFvblgao
         JoIO2HtlTbyQ8nZDd0ngjXAlg0SShHkLKw19icYYPCLJrtOMy2SGd/rPiquhvldAVhZV
         pODUAKcyM3zvJ04P0qQzHdtcE2NmgJy+lH9m3JnkZEG5sWhBF71lN5QLwo/YDEnQC0fk
         ob4QY5VkRGWg9k7NHcmNXRMbNUV55It8/Xj8Q5EyFGEHTFoB9J2yI4zU7B5moeSIs5yi
         s65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649768; x=1785254568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STnbg2Xg1zNCMraSp4HmfOF93WxrXN106QbVgR4DyVw=;
        b=BL+Z1eDR+qVbXzNYcbmho4Vk7loN7u+pcrNIa2vL3VUAYorIC+CwGyXS8Tgw68EgEC
         +XY54J2el7Au6LbnrdpvHC9OGBlUE5cDKJgkNE15ApnWO8wV0PqWF77fk9aNwB6hI4WU
         /r49mYnenW4SoSvoloCXKdGuKOxcNez6UBwdBn+/9lzeoa03N7R2lZ1aRrn7i2N8ErF6
         U49VJoIEEB1RCdkhHKFe4gi0smNQevpFeBSIE4z12ZmEZ4TF7pNBumhTrok/xY6gf+0Z
         KBCXboTx1DHFaVKHjNUhmLO4/4Uj72HRPoUUaC5/WQ3/UycD0dWMJ49MCtRNHL9p10wi
         gzvA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl8AoM4O/tLOLQ9wb6xkpwBZ/KZTBhHaWyjOkH+RBWMnvNq6enxFL5gcDrfoyOSTXOPms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWr5H9HTgTMln3awwRIEmzlOwO6bmP0YXfZ1xelE9/Tdr+nobk
	Onbtv46fPMONCClbXBw7EJSIUj7/fEuo1hrnC+NEG2sZR2wlxdPgNzQBQzqZ2uGHmehU7TtOmRM
	nGwi+95AirUTNtifIv/nUF3w6WKQnpaZgbnbuiLoGPtyXptbcLX5rEditMSTzbU4tCGFDmeol/f
	NYI/rodk5QRz1QnCCHi8Z8ayWMhqq5
X-Gm-Gg: AfdE7ck+iqBHE7RzjTg91YnCMwhAXUiaPhGd9zD97Vbw8PIraz2IPtsjbgTP+wH+KW7
	YA1k4YrisepgZoboSxoKJ7zCDiWujN/K5HxrvNNysLXPVAEZ00xjXiXHUoKO2xgkX4hQnf3IHV5
	S8kdia5JgWSNf8UduEMWVVd/DQDRGCBw+QhGzK0a1S0HK3MMX/EPayPEa0SUTjvq0ByqsCQOB6l
	s4/YTi4Kl85EP9bbcQKpyBJ3JqbH8iTA+2H7aCFe7sNl/c0w0EtiaMEaa4=
X-Received: by 2002:a05:600c:4f14:b0:495:69c8:d9ab with SMTP id 5b1f17b1804b1-49569c8d9d3mr10999605e9.8.1784649768412;
        Tue, 21 Jul 2026 09:02:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:495:69c8:d9ab with SMTP id
 5b1f17b1804b1-49569c8d9d3mr10999245e9.8.1784649767985; Tue, 21 Jul 2026
 09:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721102827.313208-1-pbonzini@redhat.com> <20260721104819.B5A101F00A3E@smtp.kernel.org>
 <al-PSX0sOPdYdvIg@google.com>
In-Reply-To: <al-PSX0sOPdYdvIg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Jul 2026 18:02:35 +0200
X-Gm-Features: AUfX_mwiJzgrlxMZTOoAY1MJbpOdubq8Khyrmy2TCut5ao7x0eFSUWRMAnM8hb0
Message-ID: <CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:25=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> FWIW, I had a pretty strong preference for Paolo's off-list suggestion of
> explicitly disabling preemption, even before seeing Sashiko's response.  =
Every
> other path the VMCLEARs the shadow VMCS runs with preemption disabled, IM=
O it's
> more intuitive to follow suit here.  And even with the comment, it took a=
 good
> 5-10 minutes of staring to understand what exactly is going wrong, though=
 that's
> probably a me problem.

Well, it would be at least an us problem---but I thought I was in the
minority... The only (IMO bad) reason to leave preemption enabled is
to obscure the change, but that's a lost battle anyway these days so
why bother.

That said, I am surprised that VMCLEAR/VMREAD/VMWRITE/VMPTRLD do not
have a memory clobber, since they access internal processor registers
and the compiler may reorder them without the clobber. Fixing that
would also work around Sashiko's complaint, so I guess we should do it
anyway? And disabling preemption can be done separately on top of this
change, which is already on its way to Linus.

Paolo

