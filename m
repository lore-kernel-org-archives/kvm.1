Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6C41D638
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253309; cv=pass; b=Wvgc5I2x6tSuv/I74fAUfViM5BlilKU/+Pl5wLQhzfMbwVjdoVeUeM1k6yo9AgSGn+pdZyEX949GZGA002DiZy7BjE3OxwpglDEm/nFbvTshgopUcU+AbmAEoVzs1CMBZ8gMm7X9rd3fWWOl1OC10c3/Owth9gIUDNNrkjiR/PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253309; c=relaxed/simple;
	bh=J70PSk4TuclHa9H+GWTRohBykqCDbewlmIAeSi0eplQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2At0eKSy46xp7Zc8HPRO8KqQeGBOnL5wijY+UGnpgk7l76lvA9L6grMRVf+aYH2oV5PRSEDazhlc4J69fOm9VGMJ6/GHhYu6WJMKukS/cAYVhXwIkD2hOckDHE87nh8mcZ2wFJNyz9PuWRR8+WNnxN20gE0lA/EA7+YwfInDQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd2XD+nr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mp/FTmnI; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd2XD+nr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mp/FTmnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785253307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMNFpvzy5MfR1oz3Xik6QKGfu+2zB21OUn6rfuSU1is=;
	b=Kd2XD+nrAj+s3HhGS9QMkkhUF7iShZq1yIOtv0GBvWmd2CZMi0MuDvmi+IL7a49qLAVLkN
	RnRZ8B/I0J86ikcaxT+TmOysj0mJSwmpmjKj2BaBF46g751sX2GN5AxzQ8je5lzEdNDsms
	rtyURZsyuF8unYxkAeAJAAvqn5umtG0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-unzcDp52MP6DUrbCER4dag-1; Tue, 28 Jul 2026 11:41:44 -0400
X-MC-Unique: unzcDp52MP6DUrbCER4dag-1
X-Mimecast-MFC-AGG-ID: unzcDp52MP6DUrbCER4dag_1785253303
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso18308f8f.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785253303; cv=none;
        d=google.com; s=arc-20260327;
        b=QBBW5JPu4r2oMilw/Zzt+cy8ZKECh8lNgm9yS6xhD3dZgylUCSYr8T4q2EpJviJX7j
         yb1NDZen8RliNIzdHC7Y4hCL5EUwNnxDaEH+K2TJ8AlcTAV5rA4KvggsCCQb20DyhqhH
         xlyGdMasTbankbE8deXSS1rNb24juJnx8VOH9WSHZXZRvRkLLYk2QLTBfdiEaY/8x3dj
         KDdNNoqk1dL3Epm2nVnuInX0vek0ylRvodVJt9d/xP8FJq9pdyHb5VOlCqa5kP/S30Vp
         aae6kHe5O3WboGmjPR7RLyiWfGpzo89xFDNRsUo2jgdQO6tQGcLbCgvOJRylL8MklKEV
         Gbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMNFpvzy5MfR1oz3Xik6QKGfu+2zB21OUn6rfuSU1is=;
        fh=MCTgXuckf1/fGim50UCXBcdMssS25z0fKSPRD3qSf/M=;
        b=GLu+YhvtiC1M/e328e/XklHWTGFPLEmtNt5tmX0UTF0CryifsOwcNqFSsvaWsMfYb6
         feABMHJ4Y/uj/cBJZqSGyNpgztcL+GSghLIDJlTDEMD0MI1ZeRW7YM+DHNZ8ffysBn1j
         TDZPVgCUrOaYmP0+wAApW96cdiBlGnTH2+GD1u5LptniFL5Qu3/FnkrSdfOOm70226JO
         cspmsA7e57XZ8JVVcxHnrq6vJEIN2/Ujht7ABxykveVbutAdXAo1XGJcKVWlDFax66aC
         ZTiztvTGXLmRJE8P21Jqwh003hwScrhbaU3uhq3UX07p3AmPGJ7O/kEWQ9qAnKEgXo3W
         j/Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785253303; x=1785858103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rMNFpvzy5MfR1oz3Xik6QKGfu+2zB21OUn6rfuSU1is=;
        b=mp/FTmnIUZlcG6YiMrgqyASES3sJ9kFcInspopSwyIR684z+L4tLScIq9heB3QfnRb
         IJ3lmmNekjjkxW7fA7eUaMuOQHG24irN2DjT+PJx160Amv4xVRiZ9q0IQTnsSOKOZ1KU
         nTxRpbcXPTo0G5acYOzz1LO7jm/Zh9srVMTL69IbLudOc5C2uhFi/q2LBI4Q7Iu7OQVl
         aI9+mQYAL5/omfA0VvcHEWJy6fO7G+4zi9Cbz4Jkq279o1BVkXUh9Huz3VbO7muD6B65
         N5W9oUypVjh/EczPkcZDWcw4H+o+MopLKmQv9l3AmX9fqQNADHTKJf7775yoHQFqJf0B
         /3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253303; x=1785858103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMNFpvzy5MfR1oz3Xik6QKGfu+2zB21OUn6rfuSU1is=;
        b=qPhwNT/jJYOLIzeKJtbOj4JtrAYJwv4OCyzRopqll7v8StsiJQ4f2z5b8BPAaRfGZY
         WY/ltRedGe40VQeq0P/1T9OUDGeK+UnTp/jjwcqfIZ2MMCKQlp5ilmJksKbwnhx6wy0i
         xgTyaAd2/FvKiw0X8k+xquKh6SLzEj0OsWXKsPsP6HXg3s7ZY6h1z5gyGRP7cWMzxl7V
         xJzrVwlH0FeMMLULH2VqfS+PMTeMMUXIXONuPKao3PxUE7PeTo/4i+/vKdeKTJq/syyG
         gQX2jXQsxN6yuI9zVExHBV0IU4fXXoP0TKfP3RpI5gt8cg4WRW30kVc8qvme7CHtSAuH
         ov6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoQZjOBZCNeJRXrSnz7NK87bvL0mAuhOOQrlgsHIjXP6Bx6t3hrhZoC/CJXiBtOxWAetTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAEA4tled3dLXQK5hd+8b2mM6O94dgQvOH1wGt7GFBoN3pV23
	BnzA7sq8+9qN+DSY1IZXA/sgJNdcDUjH+rJDU+vJXs6R0S0olWOltPKU26IjdLI4NoizTGHcNKU
	jPN/l8bVtcppIeQxjBODueZfus/EgEeb90r34jVWf3qPUYwqfEzgdIFWIKk5tGrkBu5B3m9ONQ1
	zTtWK/NGrNvbBLtUyu835uIDnaiQHy
X-Gm-Gg: AR+sD124NJr8Zmz/6NmjOVUQdLNIAI6C2Mg9zWCraq2XHSC2lwtf6Hh5gxnoJ/K5/yH
	cjEjtt0aM98ojRe7aRh88Snn8pPGuaeLK/odCFZTMMLTMzbV2zPDOIx1irzG0+1e3mBdso0npLC
	HB4+uGhR/AVvU8NYP/ijqdnoKHAnahF1Pw9nfmuwJTY5DymFmjvXlswMsr98LhSBAfz7aBxE1D+
	xBk7OH+v7pTb81uuji4UeIx/jw0xQirj7INwFqtDs2yVTr+VMm2odrPcydWKg==
X-Received: by 2002:a05:600c:4744:b0:495:40f0:e77 with SMTP id 5b1f17b1804b1-496c6415054mr33062525e9.5.1785253302888;
        Tue, 28 Jul 2026 08:41:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:495:40f0:e77 with SMTP id
 5b1f17b1804b1-496c6415054mr33062185e9.5.1785253302495; Tue, 28 Jul 2026
 08:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724084742.3358321-1-maz@kernel.org>
In-Reply-To: <20260724084742.3358321-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Jul 2026 17:41:30 +0200
X-Gm-Features: AUfX_mxhUuq42c31F7OP6DNvw1uz5kBf-VSuqSgDiWSNEUPnMa8_Yyxglsm-09o
Message-ID: <CABgObfbvvYDC6gyhw_FBPi7Bo35WPuaSyyVDkz7HA1M6wdx5vA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.2, take #3
To: Marc Zyngier <maz@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Vincent Donnefort <vdonnefort@google.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:47=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Paolo,
>
> Here's another set of KVM/arm64 fixes for 7.2. A bunch of fixes for
> AI-discovered issues, with two main areas of activity:
>
> - plugging annoying LPI mapping races
>
> - fixing corner cases in the EL2 tracing management
>
> The rest is a heady mix of CPU errata workaround, API tidy up and low
> impact fixes.
>
> Please pull,
>
>         M.
>
> The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d398=
9f:
>
>   Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.2-3

Pulled, thanks.

Paolo

