Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341936AB54
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756302; cv=none; b=garVZ8UAsv4yIC05ZCQ2bB8bGfk0dkSQWrubk2CwHp+D/BXFnXzzMC5HsK+x5X+ATILF2o0p63jjCKUgoNMYQqfBjkZh07qDiR8u9Pm+nvW+kEIyX24fi1OsN2xAuyJWPwYSdpTHzPdhqX8gJsNy9ErX2jpX38mxEQfee5Jnim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756302; c=relaxed/simple;
	bh=GXik8XMFxKlyNr0DJa0gcBwazjCkzO5/wY0cetFN0QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViQImQqwNrWUpTEGSWa4ShRhZSwpWARFJfIpCz0sTl1jYVocEGDxTP9U1wAljr2MP7Uz6APthcI8v+SWP/dYpdnNfE7VuGP3ex3DjD6752B8TfTmBJRh8AB8RDotLh7DXQDHx/QV5tn53WgYLK0Fitdj92t6RTertdxITt5TCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UduKfR+1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UduKfR+1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39675172593so2448145a91.2
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 21:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756300; x=1789361100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnvU2vBpS7iNRhfGmKqIjpkiFHsnHeHr6qR8QCexTas=;
        b=UduKfR+1N4SjTzicVqtQ7dHRjtahTW1A0ApwsHPX2zyd3lfkI0jGvOTnxmzXvuP/G9
         mwlueZJw2W3YsaKBGi+U0RIAXIBIDitwU87vnlpWN54rq7tdpZr8MR2JwvO/ZmCTQIA1
         ewmQXm9C6aj7p1pi8JwyIszxmIfs57JUvyH25z5gtpEHVkVOT1uXS3Be4okQ+Pr2ApNO
         cbNYVvPX5bSDb03qd5BsuTBI9fts2WYvgwmeIFSF2IXkvfZqxJ57uKkpVZErWOMRre1y
         ciEredKNxmWXaMetxPSs46mMVrKpSEIPC0IWuIDQnuRgStupTxbtpkjOrMVGjhP6Bnyk
         pfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756300; x=1789361100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnvU2vBpS7iNRhfGmKqIjpkiFHsnHeHr6qR8QCexTas=;
        b=UscT6LKwSpMVgd5Cp4/ni8ef1Og9fJ6vKafc43muLFU4wXLFe0h5q/9ClbaXcIJgTQ
         bXpXUza9T6a5ldQiOz29/STLdl97WojcpgsswAkuWU8ddNOZF3DY7sropnwQk4/HPSLo
         obyzjZD298Gf12yyetR8YhQ46khmUoKYAR8Ecbf3ca14T5XOMSzNRN8n7sC/gw7Ly+QS
         XmObncQ0AD0deP43sGOqPeR2vaGmtPxFuHAhV9L0wKFXlmUceLUjOk1A85kXiJ+KAfI7
         s/O6ZFImVlhATRI/cv9Res+dfAqOgVYzQukfHLkK08Ypw+arJVe4+2E72z2NUxPbt9DM
         +Uuw==
X-Forwarded-Encrypted: i=1; AKwUvBxydLx3InA61ehJ2ni1wKLmfAH4MiBQzeRHA/1Q0pnHLR0Ai8eoIojgkgls0GqObzPCQ/A=@vger.kernel.org
X-Gm-Message-State: AFuF++mGQaxc1cD/ofLMPIZ1npEeyNDKM8fytY4sm48TtN5LJQsLylZh
	4LnXagnbX+CvBLwYHLlsrzvk2Zar5uJ5LqYCFnrhNB3WJDAMYUE7Ls9/
X-Gm-Gg: AYBFou0bJoDXD/I78lLl9zcMQaiww7BhElEYYDGQ+CAXhXNd+CrPqihbTT9/WakctkW
	pjnN7bTOw5Se/3ZkbwkYBrv4hg2S6Yj0vK7iTTFJ2/gBc86mfSjNc+rIHZS6T0BUwAz0X2b5Dzi
	35cBKanFHBGhbXzOs9tMHwhNN7Ad+kCC1YdkRzSv4EYmux2VmKLj142Q1Z8Sbfypir8yZmQbX4L
	2oVCyAHrLx2wUsdRcfP8z04wr1fdqhYiAUgD43uosWdCNGs3hXi5u1SYSrrl4fapp7bWUp/bGOC
	5DsM+gsh3QcVIRn03XRa8LBeb0y0X4SvCJfPvS14RGy1XxhK1U4Wbp+d8GlGSfc1zcxaHujyfDI
	QVtmdXparzEZkEwFKreR0B/Et2xjL0EPL40Of/gxSnc12s/uA2gCG3C6rnS/kccgPOMyU5OzLNh
	PIqlaOokUChiKn9YnRTXBCOMkO0Nwi9dZFCJo0HqaclHzTsNMSvySMqxgfNm21i3l/NeohbbRje
	hyaMoVh0Uv5Yg==
X-Received: by 2002:a17:90b:268f:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39b2612eb96mr32751634a91.8.1788756300129;
        Sun, 06 Sep 2026 21:45:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37823751eec.16.2026.09.06.21.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:44:59 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: kvm: fix typo in pauth.c comment
Date: Mon,  7 Sep 2026 10:14:34 +0530
Message-ID: <20260907044434.4682-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044434.4682-1-hemanth.selam@gmail.com>
References: <20260907044434.4682-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment reads "This code assumes that is is run from EL2".  The first
"is" is not a repetition, it should be "it".

v1 deleted the second "is" instead, which left the sentence without a
subject.  Fuad Tabba pointed out the correct reading.

Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm64/kvm/pauth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pauth.c b/arch/arm64/kvm/pauth.c
index d5eb3ae876be..bb6c42e78058 100644
--- a/arch/arm64/kvm/pauth.c
+++ b/arch/arm64/kvm/pauth.c
@@ -5,7 +5,7 @@
  *
  * Primitive PAuth emulation for ERETAA/ERETAB.
  *
- * This code assumes that is is run from EL2, and that it is part of
+ * This code assumes that it is run from EL2, and that it is part of
  * the emulation of ERETAx for a guest hypervisor. That's a lot of
  * baked-in assumptions and shortcuts.
  *
