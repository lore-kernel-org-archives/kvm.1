Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28A2DC765
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756284; cv=none; b=YGUsyqDMQhcVsRF1087UePrdvpjyH6enprUBtbE+71s+XqBID1IcILic0qXoNuSk2014tuUq2aT5f2EXirOYq505j/74aEP46E0JwxFg0woDaRLKYbQ7lnMVWxCbTmdR2tcY3HHIx5ifisBQXzGGQj3TvecDE3eImje/Iu65064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756284; c=relaxed/simple;
	bh=ISslVk0idEPj7E8QqGvX7pQ3utIJ/ZKVkkttDiU8+jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BC4sdvGo3yaZKLuF0fNRjM+ZE1WlIa3Vy99CN6XWaukU/u8OGrA9iGfTZ8Af8jzu+rcpDC8mtL0jKzQ5pHXUw5q/NiY7NxtUMDgyZn0ixxTBvjYBLFNPUvYaA5sQUWl5IZY9JzwjLFgpL4TIRUDYMrA3kmm6UVd8OFtl0rSmxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxFodInM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxFodInM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so4148025a91.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756283; x=1789361083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tEZDkgun1SxnDcq7CXUxTgN3EXXb5PDIeu9LnAI4BVA=;
        b=gxFodInMO3dgr8EB1INb/DmeIPnllFpru4Tm7fPSy1fk9KZaIBeEDFSdHmTVDCPIw4
         E4uC74XppQYtbmmN8V4ZzwOM1ojubEVJFyrQAGFft/l0F+PA08elarzNmvp1zrGClxe5
         pyIqtmrMPNWbL202sQ67X2DFEr7b1atJ+kKK9fFFK6cOv2Ev3hrNLBPGmeyEMr8zcjkT
         TfOK0fNPspsM8vkcNQjUHpdVWGnPB81OVxuTbmkZVltPA2MfcMLztMqgi6nruLOmXlWA
         0lU+/5KQ21xPWrrIapVXGKJWUue5U8WW4NEEW3o6Jax7rqBh0DFAZmHH6lksWLLQCOFU
         GfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756283; x=1789361083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEZDkgun1SxnDcq7CXUxTgN3EXXb5PDIeu9LnAI4BVA=;
        b=eEhyFqZwNI22RRnzlbr+DtYlbmYvHqbE++3frfy4+mL+C+Jfm9KJsf33ERLSdJafe2
         Yhu9zuOl3y0kEGqSyv0z2VuCe5ACV6E+nSh0u2juhXqXu+7Q9ZYV8B6aVuXlr0HLJacb
         DObXgt82Cu23lOETwV60sT842K5TMd+lTVklvYyx3p511NQyxfyGnKju6rM+b8WtqYuR
         XlvNCHMo3+G4ui1Z5GZScDkPnyKzmOgdywQoZTJ8dmqLHm68IKzpJyydtbe3R6DqQdc/
         Sho4vIFKr/I2SbGq8uZFGbg6fj2/n8KU505VJKwht3/MucGQLtgnTzLL2voFC6JolRFP
         92zg==
X-Forwarded-Encrypted: i=1; AKwUvBxcDwa1vV7DhLLin9cUNadYekX3P7lwosLLGIMWQamYLTmDibVHlQTTrCrd2KMxWmA7OoU=@vger.kernel.org
X-Gm-Message-State: AFuF++mjwFvxSQ5gDylzANaWDitcmXvRYVFWEPYPvFvbiYcIMBBUOBg/
	moukQsd84IWB4pGFp2zR0jNf/+PxMxDhI61SnfboNETFJPdGg4H/bTFs
X-Gm-Gg: AYBFou2UfTJrPnZmUPiB8hF+eYwXSyBJyPYCz4P9ESMbzN06Vl6WS5Yaeqy+OmoKLJK
	KN8wvUErUaaUTcdigmci/d8u+NUHVOPpvMVRXPknkdVYFVpseVyByK4JDSywibdHf1CeRwTXIGy
	6zofPs/mvycPoj4w4YmxRrpuSt5XsYrImRpXKKe5GIoKr/wewu9pTMD6PsQN8EtOIkL1MpmiMa2
	ax8TW/Z+NYeyfO3/pO+jOiLTGxL8Mx46UOEmcGLChve+R5ZjvdHqrA6fjCKPPFYE2ZbExp4up+I
	FdLiXvwz+u9WA+SQls1E6rsfmymXnVVeUfQH8gkXmmFfuUd3wHxtkYljK99P3NTljIFFsZ8Asy1
	td6QvnzHkH7Wi4UqCiQBcRJvuXFs83FbivAiwVL62gcS2Aj1cShLB98PksNBzb9zU4jrrpjvklc
	2wBkrATP90gB6SddhuTPVtPzrojcUJMDHKnp/2QSG5byldUhey+8RWppk/Dj9XhUsscsr8Qy9bz
	8IgWwHPgYU5MQ==
X-Received: by 2002:a17:90b:2ecd:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-39b2609f306mr35329992a91.3.1788756282789;
        Sun, 06 Sep 2026 21:44:42 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37823751eec.16.2026.09.06.21.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:44:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64: fix typos in comments
Date: Mon,  7 Sep 2026 10:14:31 +0530
Message-ID: <20260907044434.4682-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the spelling fixes for this tree.

Changes since v1:
The pauth.c change is corrected: the doubled 'is' is a misspelt 'it is',
so v1 deleted the wrong word.  Spotted by Fuad Tabba.

Only comments change; no code is touched.

 arch/arm64/kvm/hyp/entry.S                           | 2 +-
 arch/arm64/kvm/pauth.c                               | 2 +-
 tools/testing/selftests/kvm/arm64/debug-exceptions.c | 2 +-
 tools/testing/selftests/kvm/arm64/hypercalls.c       | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

