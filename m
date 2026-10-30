Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330992;
	b=5aVYh6vTU9pvJVGlerkgZaXEwwd8GYgCh7ryZfL4U3SFvheTZsUxHIZ/PPAsfokQ5ETo
	 YN9dqfsRGHXivTAWdX05O2Z85oqGLCkDb8kM/1y/ZZm2dG7OJry0zwhkKd0VD82BRIPF1
	 /bCICJ69jAhoId7Mvu4+Rta6tgwRt8IRdlHnVq3/VXDyV5k3+qWYsh/F0CjxM4sRaTwaG
	 vBHzK8RJHLrAgJU+JKaNwBN3QXC6InQb+LtxVMgY4T2hlra+rUjtDahqbaLK7JeyS5FB3
	 UcqD+dByOX6BiEVHm94Wy6BeObbiN64pBN5TiS3E+DPj2Z12Fn6cdIwJCuaBcpxaKRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dahY9MpT6qRl250d4uUuF1qZsWTwuAAtLrsM4UyodQY=;
	b=mUFgcTZgsFn4kOC4Y7MjnmAjiYcmrr4fQX3TiidHBV+RNOKUG16xRciqn9jmO5vnFXbw
	 1RCih27it8ZSNWNJymcG9SjH+iNH5rh12QM+s1Xiit2E5q4iNsRzuS8wiMhWcufn1mxit
	 p5SyhPR+5wnWgg8Gv28QZU0hmm7z5FHg4j7p41oVSPrbk+8nSaFgvBpWIvLaOtAmw7+xq
	 8xnFPXHzW5CZglHoo1UiL1sw/5BK0uFoWkC2Vt3rLgCQh6MU3jpMiMV9JVK4BFrZTJYX7
	 bO4oXtOlVkl9xuIf+74H6L0dX3yb+8IRKpA5qbII9QCuTyFGphAHOZ2x86PnWReqwWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+jOzsvZ;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F927606A32A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 03:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F927606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+jOzsvZ
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso67759b3a.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330992; x=1793935792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dahY9MpT6qRl250d4uUuF1qZsWTwuAAtLrsM4UyodQY=;
        b=K+jOzsvZ8fin3aq2OVYoARcSRIp4cKZM1dLjFNCiPZB3P8CvDLZQvCxwfrpNUPqWll
         yPhzZGmnQBxLkEdTB6YTG1dRqgAMlV3yDUX2z7sLf4/A3lJs+fUj1Gjx0J8CzNSvjHa2
         /HJMIm5t1VpDT0X5dNFoGZKvXdJv6rcI7N0ayVH4viwXXpjWBQYW+kTlPyNEVURI92iR
         qYxXi6UENCEHwMJtubWtm5TrHBTzpDnKwZkjBd0P8mnHEUuIIM1qcOej6mBdk/ZKDMTT
         UkMerMaSwC8MmF6GhlSIcnfBv7ScFFacQdfwS7jQjwTwJyGoIP0yr3deSeFJha7k1Lli
         9xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330992; x=1793935792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dahY9MpT6qRl250d4uUuF1qZsWTwuAAtLrsM4UyodQY=;
        b=VNId0YBawlajGZ2Y2bpySPX999QK1Ids7lO9XeLDd3EoGYxDoY4qCk7qxsUMjzF20L
         xBPVGc5o8OFXV6ZXlrm54jr+StlARV9EdGRoeNzvKSadZAPf3++rO6aRrsv2Cl9gg6OV
         T+tGoXWwWvqObOojVvN6oztp1dC4x57qFyqBmpahYwJ7dN2kLnTGEBFJHpxAYiVWGe32
         P99lZy6cnDbLCPDDMjLwW4uN130nNjNprKiXnm/KoM7v0rzeuyoxNo/mEBWZUnR72hjE
         SRN5DRk9+UiWcp6qjC5HBVONHgiO+7G1AfendhJn90df2eGbSI8FgOY6RNRMGB2zpNGX
         yBbQ==
X-Gm-Message-State: AFq9FYLG1Xf8hUPg1RqyEK6ieZeAeEzpvPjEiIV17VsuRP83eyimOgj9
	G7JpTS52/Zx1+k943be2H5idUcYfBJK87305PbtEW9YNUU77cTJfxsK0
X-Gm-Gg: AYBFou08XILxyGRDAwZpYKsoswdBqG5bAbMJDruDayatOinlXxACAGMDHFGMX5pNea/
	COaVgahaJNiMkPBj+OneSSjC09FanOQmjZP0gYlFAmMlvT9lTcXWCiB55iXpnCDYM6OP6USTjLV
	sRBRgKibeCPRuMZjx2dH8RP74Q9ELa+gEFn2UdTAZ+jHu139TnnFFauqV5n3mwZynehV8QCyLRK
	d5pb9oAFVzMO0o4CrfjL10EN+KOcwc3a8Rzi3CWBQL7rJydwZtuaSPwOqwjZmiwfcQTJpGemkxB
	JtKmoP94LOuLj1uYAPh3bAyepscYttlAz6SxRpUQWCn5ZBIY6yYllEgh77w5umuFl+2dIZAhFYq
	k4rcZypBIx9D6S8WTrc714fTw7ytOjoY/TZ+ABwicSdoSwUCfaC0Wy/dXq2VoZKsPzlYmnNsJsf
	bWKlHHG68rKlXR4tFg9LItKOyimwDp2mgfypWYXFX/ogTxmv0FKtSVTA5lcnR/PESg/rgofGxWx
	CseRPXT5GXhVwdpCzhh6KXCJHEoraYGlprYl3lI/tY7VlOWlCepV0R96LG99afUpx5RY2wNAZUj
	nIRjo+MdYB3ct2yS+oyT2HIW6Sueb2JwAoCcnEHILQjnDcvZKwqSOKJyGsqTnq0dPN4/8xurSJB
	hsQRMF79HLrSga8urwEySNjD1FfUSe2h+4Yla9xX4n5SKnKsrub8gVjbt1hEHKS9rY8oQZKtR
X-Received: by 2002:a05:6a21:39a:b0:3e2:8fdc:a6c8 with SMTP id adf61e73a8af0-3e9290fd040mr1054244637.72.1793330991760;
        Thu, 29 Oct 2026 20:29:51 -0700 (PDT)
Received: from localhost.localdomain (S0106e0dbd1c8af8c.vc.shawcable.net. [24.85.96.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981c5desm111713a12.27.2026.10.29.20.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:29:51 -0700 (PDT)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 0/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned by L1
Date: Thu, 29 Oct 2026 20:29:35 -0700
Message-Id: <20261030032937.2813-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.40.1.windows.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When L2's LMSW exits to L0 but not to L1, KVM emulates it with=0D
kvm_lmsw(), which ignores vmcs12's CR0 guest/host mask, so L2 can change=0D
CR0 bits that L1 owns.=0D
=0D
v2:=0D
 - Patch 2: order the CR0 store before FNOP and check L2's whole CR0.=0D
=0D
v1: https://lore.kernel.org/all/20261029235040.12013-1-ma.mandourr@gmail.co=
m=0D
=0D
Mahmoud Abumandour (2):=0D
  KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned by L1=0D
  KVM: selftests: Verify that L2's LMSW leaves L1-owned CR0 bits alone=0D
=0D
 arch/x86/kvm/vmx/vmx.c                        | 15 ++++++++=0D
 .../kvm/x86/nested_exceptions_test.c          | 36 +++++++++++++++++++=0D
 2 files changed, 51 insertions(+)=0D
=0D
=0D
base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4=0D
-- =0D
2.25.1=0D
=0D
