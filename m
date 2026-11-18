Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795006574;
	b=sXNjiD8r7qmdyRgPIj5N+ULGMpTM9kM8kZwH47lakVqa+Lh2eiAe0lt++nQ9WoTRvxBg
	 C52YjqHxBo+KQtdnwx++V1Bgi74CLqU67QRK7/Nr2/2tXXQjsHG/UnKeeJnVLVv93GJRA
	 dvYHGD9zqrqySOcMyFlE4C40+makPc9Q3LO4XLA5IiLhM33i8KLLsRwI2GL58gWbSj/J5
	 ExET1hAYLG6RTeCrd5USgMXlZcTolOkAf6Z/SXMYBX/5/vBR4VT4EvGm2PX8UMS5clD0M
	 tSfvH1q5sRj5I0t+sm+XN1WZflfttILakIO6hkK8fyghgVwFI1yWrWqrTPrEHEFFntg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=Tkbpkl4u6/wMIWhAzzn2JPkPbccRRsyKhFFxZHh5drM=;
	b=4xy6Kf+cP/ROk/oU+CC/N+1bkIPBxosYlWrUgkmSuUBSaDkeRbx8EPBKI9Ks6py3Iq1M
	 yyMn9CLTKq6thNqVKeUOoLcedOvNZih/lLqKlkXIP14rAV8M+YGJHy0J9IIQOzVDk3o+C
	 arsU8RvbOj3YVb1t5WTUhSuLSSdBy/Q9E54g8flRbKIYRA2vIgSgxF6y/ulJwkl5miA/R
	 Y0rRelgPB+bYzOTnAXqFYWLLpoqhicC0wi5lGZIJZt+rx68hdW0IeLl1ahVg2QBOWQWSk
	 qVCIYtQmRysYBAeGHzHhVLdf3gAM7OBBrO58CKR2s6XC0pUKpsjCFpQG+HR3Rqk1G2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLITcVgX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA04606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLITcVgX
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso921908a12.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795006572; cv=none;
        d=google.com; s=arc-20260327;
        b=bNIb7+5udYP9vX15zO4XHsnu6G7B/fjPe/tRm85jqEmM8V0t2u4lr60UdM+cvYQfeh
         tvdqtzlWSfJa7B5ijRamke7vQwV4DMvFKSOMd0WpLkGfmMzx4OKwm38FddCNITB1n025
         d5JRbOVa73lKFogC5MBp6+a8t91u9jP9ktL0aqLVZYmBgBUb8baqh2UBgqrbiFwvdDcf
         cIjBbb69vcueNVhbhGdjK9BdBesDdJ5i54OrHO4n/mR3Tc4cbQOrA8Pj++ci12+xH2ZT
         CBfRpOQQ/8qITd282xwl4koYTmVHyApnzUf2otqJl5DnEZw+b5OLPRSHFjP9Qur6rByt
         7zcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=Tkbpkl4u6/wMIWhAzzn2JPkPbccRRsyKhFFxZHh5drM=;
        fh=1tv3lT9FVMllQvfGuuqirVkP0I0g2lXPr4vcP2AU010=;
        b=BZZ7TzTHIKKt58xcSWX35M9ff+ulfhYMBSO6I5uGRmzAZP/vmfcRkkWR0CnIFaF/oX
         aFXMDxxVik2p4RB3RC7BpNRjHndNtEMJ2SCx1RrEypKdad298ntsQjg/nyUN3RLoF1uu
         JTi7uz1G/ekyGLKVTqYz0petvXFN6n5uVPLoxaQ8urbT2PkO+c9Xf4mDLGYw70V6CpIH
         fwZml03NFQFdx8f9yTpbs9NLzs682mEgLfpfb6uV2L/MZPESSTBewykKnYGQLSWJw8C5
         rL37sxcI5bgnzgHx0EkZSNwsFPFdbk0i7x2Wv3QoXqfFJdvYpd9tysMPxZ47MStzNnTK
         KfGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006572; x=1795611372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tkbpkl4u6/wMIWhAzzn2JPkPbccRRsyKhFFxZHh5drM=;
        b=iLITcVgXNuTSh7QCsrIvLzsy++4+kHVt+A5d6Y/KHs6sOq9JbVpenyLhCtzEhe/eT1
         iaybBKENP5yaaoZgCsBFsowWtM4pyumBgYwBdhhX7gEziY9t81hLi4/lj53vdRzkd4p2
         tSlbXcb8tINbOzHEnLxr8jsRmdi6EOQuJGdwR3JBuC4HVEn1nSP0q1+ZZ5FT+lkOaFrv
         YaAiihAWuz+3sMtLLmtWB8NTkXVOjbJpvuaoBjUMGM7OO+8HmKVeJRsgu0CkTa6WyM7y
         tpJpA9CmzBsObORHbKPmDE6qGwMHbiJOoX/Iw/SVLF/1qgoxAeetONBA/i3gpo5sBuJG
         P3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006572; x=1795611372;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tkbpkl4u6/wMIWhAzzn2JPkPbccRRsyKhFFxZHh5drM=;
        b=x4r7Lg1D2IvlMGhL+FXyVxiC1Y6E+QYK2Sd5dT3hV1ki6ECHCKzAcbopIzqySLBVMG
         eROxm0tc2KTUIukkN7iHYwwKaXXQ1cHDqoYlBm7vNM0vK4QVDpSZLgx9V+1IjekSMNMm
         m2G/a/3IacNkhWO1FBEwP1borlKRyNs9jqtklnHJsOvbInHEtuxmujSb6FDNfUo/urBS
         SgQnGNJO4ymwbeQLekwS4tFLY3Yliv8NP4EHdTuLY0jB1ORxRIZZc+jGrbRjc4uOrEQD
         g9d1hIdycBJFYfebGHNidFb2U9mzUZfEjjobj8ZLTb6Hck39omr33aT2et8ut+9gPoP6
         Gp0g==
X-Forwarded-Encrypted: i=1; AL+hErFRibD117fHw44yVGjt+dsSa/QVtHRT0YnbjNbVHEgpMIUTB49Ms1R8p3WiP92trxeScGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cWrCGLf7vVEqQnqhJ06ZrRVC7jL2nNViyFmFxfmVwTIpKVV3g
	r29UUZ7Ethlv/5SdbqssuEiV9j78iSqcCARyGoPpBTYhzA7LPVct8gU+SVsqsZ/fOX92/8V8GIY
	ouj514WhZBWD1QCqIjVRbCExzszkgTAc=
X-Gm-Gg: AYBFou3lwBlefv7ewepCtzJTWaQLAbb72yi9xoZ+12uCKCtToS+fpTEcqTHshH9CiHT
	oGo8HFqSqTKDcyQ4kwIzsbJMc3d+k2JGfgazLeatOxo2iYiccq75ifYVY40K4oGrs3xqP0lt34a
	WIPRjk5AIIc+cadMFaWQ9aUja5xS/ZRBJM8Gyzev9W4bb7MOnwdTebV+rJsL+dXCzlbv5AllzUZ
	vPS9QDRUuiXKWKsoBYSDLvFiHArbNoYpW5Ta7X2FXs+hhOzKWNS29TdZa0wPNb5PY4FCSncrErd
	NfYWN4SYwxC8xVqDVjkcvVNPusfRA5f/55qfKk+duXSpBDWDTpB5DkHKVlW65PIF+H2qG775LIz
	F7AeaY4tsrSnzxY1bG3nlcpPzTd/QqqCGespiy4ViRQQ9O1RFYRt8HF1srTLqACNPehgmCew2Im
	90j8hrx6PVXTw3++kzCokdN7uVbhYTzLv/4qXEkBsXjo1Rrhunx7aIJFeqIIWAnC4l1JLCNuwTM
	wA=
X-Received: by 2002:a05:6402:849:b0:6b8:7d98:4836 with SMTP id
 4fb4d7f45d1cf-6b88810e80amr2170180a12.35.1795006572483; Wed, 18 Nov 2026
 04:56:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Wed, 18 Nov 2026 04:56:00 -0800
X-Gm-Features: AclHuK97WR6FrXWOKPivI1qa_ids-Oq6BCpGZP0pKuL1V6w7FkflKePR-EYa9ms
Message-ID: <CAKSQd8Xi22AXCF0OMRsF43KymVVM3ftg4g2TjBoURPeA0dcxDw@mail.gmail.com>
Subject: Re: Re: [PATCH v8 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: Jim Mattson <jmattson@google.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	zhao1.liu@intel.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"

> Per Section 3.1.2.1 of the Intel APX specification, all opcodes in row 0x3* of legacy map 1 trigger #UD when prefixed with REX2.

For the sake of completeness...

EVO processors support 0x0F,0x36 and 0x0F,0x3E [1]
and they actually do support the REX2 prefix for them.

--
C.

[1] https://lore.kernel.org/lkml/CAKSQd8WQDfSax83Fyja0Y_aF-jq+7qfOpDo3GU5bz-8wEVUA1A@mail.gmail.com/
