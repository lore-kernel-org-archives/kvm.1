Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B82264D3
	for <kvm@vger.kernel.org>; Sat, 11 Apr 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910305; cv=none; b=WlLPIQ77U6Uobv33mavCFqfTLDOk0DT6LQNK8JaFaCEFiegHsbLFN6l1PR4xjnuiTRCxYge7ADmSUYDAHEQtzWnj3Y/C3PBB3JC59Y4d3fTQbNT3xmhGRrNWfiCvwVP1vNu0ArKuu+2Qa77CxCjFn2NyH9OTRNtP6+gBpD/MQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910305; c=relaxed/simple;
	bh=IH23IsYEfMnLl0vOqVuFFPauou7jx8fKybZDJE8/nUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0UMbYRQCn8IByhkyi1xw3qsPReTOQMb2QHdfJjyIJxLKgA6uqEeFhdWmDhLG86RuyHZC5DlBpTDKB8kL75zYAms25pRVC0JkmjHiHAtuTy2odP6vRam2ePkNs4S/r6BhXX+Q0RIYABCHFLSLOwJTBX0eUZpdTc8wpuZ1GfS3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=is2NMae2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivN5nVos; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is2NMae2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivN5nVos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775910303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iv0cx31QAfhWWU8jGatWTNoayFtnubvT7XcItOfbo/U=;
	b=is2NMae2oxxckhT+2DrXJys0aE4lNYqsQh8kp2Koy5EYUb/FLzXdw+WrytTb1rh0lT0ABm
	o1yWMK18dypZ2wUxdCVMq6eKzEGGuWt+bgGdg2v2FhFui7e60Wk0IPhd1ma6w2cWIprk/J
	S6tZPQoZHzALuaY5pTscT6U4IOUKp98=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lrWswaQYMZG-8SWIcTAUog-1; Sat, 11 Apr 2026 08:25:02 -0400
X-MC-Unique: lrWswaQYMZG-8SWIcTAUog-1
X-Mimecast-MFC-AGG-ID: lrWswaQYMZG-8SWIcTAUog_1775910301
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483786a09b1so30230115e9.3
        for <kvm@vger.kernel.org>; Sat, 11 Apr 2026 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775910301; x=1776515101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iv0cx31QAfhWWU8jGatWTNoayFtnubvT7XcItOfbo/U=;
        b=ivN5nVosH0Z5uXAfkhNDPMBHE6BA4uk671FDNGofbdnaGEV3bObijPa1lh6pklog+Q
         U5WcG5S3/C/fiP5pJ0u/xXEgaRLHEZ72+vylpu3ayoT5+trc8CHYGq5TMkjLIhEHSHvU
         EPuEsRLt19paz2At93Ck9NJLQhmVMyEx00Dv6HydBhfjjEBih2QV2kX/sIG1/eKzUc1T
         jstvv2SJJa1Yfg1I/zg/MlqFkKt9bWYhlVnNmRu3Qvi1rhNB6+k/sjnnJoZjFnaGGiAH
         JeyaiNIqFTK5odQIcOp47TJhc10UvuOZUuK4pKumK9Xl4KlTC2CoidUtmsSLEU/Qsj2j
         ob2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910301; x=1776515101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv0cx31QAfhWWU8jGatWTNoayFtnubvT7XcItOfbo/U=;
        b=D7B+76Ys/dX8A+AAxDaUO5el1EDCVq9gZ/NsI47H/66H0ybhAEtEJzBsEd7xluppYN
         /gCNPmR0zlwcce/FO9AylCMLLpNxyn5ZczmQjVHrpX7FlbY4WdxRydqpWsiru/lgE/dg
         RNmy68NdEp7GiRzVqHtMNg8dpLtcVkz55RX/r9H3DDGSzUzHZPExc8S4g8FyoN1DSuKC
         /MRJnWiSyFrSPxAOmO6eMtZwThu1XIwRh+xVHsCSExlY5hxn6KIroN4sPRKD1ygorRyI
         nU0a1VOvwRecTtmTYVZY+XeHfqf+npvytoUdDemKmI6BP9Njr0Szr1Fft9ehXn9qsX58
         pHow==
X-Forwarded-Encrypted: i=1; AJvYcCV769vRqc9OeNKbXtPZ0pjp9vYtYXFRUDPHVf9pUfJhmIUUBm5URKExBT0hVwjsPZNTTd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRBXz6r36YwzUWLUdPTRhhcEz86y/LJ2i/Yy/+tT3VUu+TPjI
	B3XRVT005teGPLlKYf48Rr2lHIKs0y3qAWwEULOPbEjDGQoGVXipbNEWYSI5mYGADqbyERgMtcI
	WKiKaMatosVbPcI11RS3g4olV5Gh+laj6DbtDevnBJxCMKzEkJo8U9g==
X-Gm-Gg: AeBDievVX8rETYIT/HfYdTgNk9yV6U07n2kBv0TeZIr1orYqemnqK4TQCwDy+/4953i
	4ZYhO6/PsrP80Yn6Y5bq9+e72E+47sadh5WmUmdSd/h/bddPyVr2FLNQ4Z08VfpPmBY0wVCJWRf
	GAV0Ouckr41kQgAadQ8g5obnBs59K5fQO88mZQF/DyVjwaOMLkS/sBbBQPrFbCyghLr9qaBJthN
	4kCR8bM/ip2Oz1soA4GFAgiY9WZRFLUptEj7mK/gUdP+U7jGfCNF7B3H7VK2nYP04KZBK9m5Gwg
	2rbISS7DDOcMcyMAU+MEhEBM5Nmqg4lp6SFnSfJs8ak1Oii3ACXM/8rqhYSBnCbNM7z6Lzo05iS
	Q/02Vws9sgvuJbTKeeZ8G7YGVDs4ul5nCXTIhwRdFv94hBcLDdUo78Pba62rMSJ80EVVo0AmhZ+
	PwRcP23XeSAkfz9+DPwZwPeTnZYev5LXSJ5YXQVU3HkgcbydVomTsCRl63pnYhyg==
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr69454005e9.10.1775910301012;
        Sat, 11 Apr 2026 05:25:01 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr69453765e9.10.1775910300552;
        Sat, 11 Apr 2026 05:25:00 -0700 (PDT)
Received: from [10.251.239.123] (93-38-178-167.ip71.fastwebnet.it. [93.38.178.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm138908275e9.4.2026.04.11.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:24:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.0 final
Date: Sat, 11 Apr 2026 14:24:55 +0200
Message-ID: <20260411122455.87172-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit bfe62a454542cfad3379f6ef5680b125f41e20f4:

  Merge tag 'soc-fixes-7.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2026-04-06 09:03:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 1fe7294dfb7d26f70bc8f6d7aff26bf76ed32214:

  Merge tag 'kvm-s390-master-7.0-4' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2026-04-11 14:11:23 +0200)

----------------------------------------------------------------
s390:
* KVM: s390: vsie: Fix races with partial gmap invalidations

x86:
* KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

----------------------------------------------------------------
Claudio Imbrenda (1):
      KVM: s390: vsie: Fix races with partial gmap invalidations

David Woodhouse (1):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

Paolo Bonzini (2):
      Merge tag 'kvm-x86-fixes-7.1' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-s390-master-7.0-4' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

 arch/s390/kvm/gaccess.c         |  9 +++++----
 arch/s390/kvm/gmap.c            |  3 +++
 arch/s390/kvm/gmap.h            |  1 +
 arch/x86/include/uapi/asm/kvm.h | 12 ++++++------
 include/uapi/linux/kvm.h        | 11 ++++++-----
 5 files changed, 21 insertions(+), 15 deletions(-)

