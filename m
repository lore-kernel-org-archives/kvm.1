Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546916;
	b=jpojP1RT4bghhPNMfijdwsQi/jlW+mYmEfnoll1HQp3v4X0/aadHkdJC6a1dydE0Ahqu
	 xXQy9jYIsXCz7nuK/xbSbHwba9ybjmpgDxShtERdUG82KXxYRBkQjrf8t4lLvH0I29d0r
	 SxwumJzxKPb8+aQdwN0i8lK7OtIMxkxXRE7FYBNceF5qOfFoy95fgsK7H/USBWOqOj6dG
	 l+pQjsytvpA47GOXl0sXbCQEYFsTz8J1ML+IRrgZvtnaO7r11q4nMoB4KrMBEFYuGJLS+
	 l+uCuAU3R1qk0OvAWzDKaYh6ykvBqJIEpqadhJ68STL3/V51EpUBN59MavfBulrSjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
	b=D7CUocqxsAz9UO2uQb5BAGK0llmMonBFPm8ue4sGpzvLUDvuL030smPZ4Mf2k9vRppR8
	 or0anHI0KaxTv0C4jnvVd1bBZxwnrLjqwYgoJnZOUulNrwrfcLsRAjvxnWWzyAdmATKP1
	 MO+yfZutSzB6zq1HoOPbRAHJhL06JLKR/SigjC2+THwzPujaj6Z2vWPwfo3Wh3lD9o4Fj
	 FmKWAzQJrheGIQhzF5EF1Wh20M9qYIzxP5bQQCsq9cPGDU9g/ohRZLhJXjDNGqLSrCfx2
	 rlQBZvHRxCwTJ/bjBbsuLBTOinJ7ii40wWEZrlL3FmQ5EKiJo8kEwYKMqB/BvDKZx7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Rd5/l0dK";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E186606A32E
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E186606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd5/l0dK
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2218063c88.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546915; x=1794151715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=Rd5/l0dK71j+9Py5Teg1XlIb+lIPR8BLqXMqPRuCD9UBDZKEQdgmsPjhwTI00BdOpJ
         PCHWtQRS0+uMJ0cs4ORAm1pSJYCEE8Sw4o5QenDI6VRvCH8YrEl439df6F0UWfCIdRS0
         AXLtOKuehag2/CbCoiOoyPRSBHfqSP0jFxNdQOrJUBbdEcSi6MweE9TbszidtjxiM3rc
         62bRDhngTeaHny34UWDqC/o+ZEY5nBd52nI8d3LSRTBZ2RyCl+iKS4hiH7MEQbU4r0fu
         +0ApZ5Y+nMvjPaYcf0s/iSrCi9dm7xyEp8PmSWjCBmkL1B3RQEw+og6Jtua3LuTmyzAW
         ASaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546915; x=1794151715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=pKKwWUnx5vkox9RZYf7GoNNJs4nyix56cN5a7c9iJmsa2FxuATlPv3ChcKBM9s4kK5
         tRtfNRmbgXS8AIKWG8BMkR/h2D3Xpq/bsj5sT6YfWJzcAOCjnTgHCgLSIHKoTGQ7IE7Z
         B7kl17OgACDCoRphnfaSeViMxFwTSzgYPgFLyxaY9Ogo619FYutzTy28wJfwjC9osYAq
         iCrHlgNXHodNsgbg+svue+NUxzYGHq9mDY/rVFeIWnTadnXsyF/KumADebZfgMjZJZcm
         IsqxPWcP1U/8IO3y7w273lAzHu9gsTkX4zaVhT/SFTWJrSorSlSC2y7u7wwHVbQbWMfl
         FzKw==
X-Forwarded-Encrypted: i=1; AKwUvBwwv/QyH3QCyHxl3c8lPPFe6NKzEsivhbUBkGn43s42JFgcZ9yhBEkQ3dRljMoQHdRxhfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1ZlvrTuxkHYThVI0vJPQO5Cm4kTXy8TzYZuumrjy59EwxtDyu
	rBIVW8vRCvEOuos6vKONjqVAPHxork8DmXifElYm/5NZeV1Pq+AyMcX4
X-Gm-Gg: AYBFou0nKFuPk6xP4BHl4Epd5INPFwA5+eg+NI6mXBaFj4s+P3yvBfXe8cI0Alwecp4
	RiK+2x9e4cxPA5bPyUE9n2t6CbrAj2sq67cMbx6i4ZidDGZm8JMnqw/kJ3+iN31aFP+vaUq9OW9
	xV8k4+UoxLcbAspXUFKFvP+kFkr7wLHv5C89NkDubeoKj8BC9RlKxa4qrWD14KEcZQ/aSY/ZMky
	pE38iEloaz2nOilzBmeJWllSsWti25LXnAn3zehIbAqBWBbauun899j/4IK1lR4+GLZfg0lEXQf
	IGbSlLeFiAulbXmnVnXJPI1WmTg0oVTIrIX3+TsGEjJcokvq2kuk5JCuMwOAuKUrbUlqrxsL+xl
	KjxrR2zM2Z3CWDXxt29K4u2QTrdspEPC1kU10q2z+rcLvQSISS24jyjGqPXPPRvla1OekYzyx6g
	F6JvhgWBksBH6Uq+k5buzCPmNuj7xbaMzXBPs7JiejSiOYMI6pmLA2lfWfVRZqPC4D0BIEMfPxR
	gfI6xZc66Go0GBY+p53Mmk+7Vam2JJhOK4OlTFobPUF6bfh1WxzQx0s99tZByW+Fr9QIdO4WRCr
	1WH1/flcBOVqzAQCKMDGrkCMj8uEnhCh9A==
X-Received: by 2002:a05:7022:ea4b:b0:1a7:979f:ecc0 with SMTP id a92af1059eb24-1ac5b7e1074mr11081302c88.27.1793546914963;
        Sun, 01 Nov 2026 07:28:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:34 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 3/7] KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:58:08 +0530
Message-Id: <9d5d92e93197ea43468312c82417b2f24159cca6.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvmppc_core_check_exceptions() has the same pattern as the Book3S code:
it starts the scan of the pending exception bitmap with
__ffs(*pending) and is called from kvmppc_core_prepare_to_enter() on
every guest entry, so it routinely passes 0 to __ffs(), which is
undefined.

To be safe here, let's use find_first_bit(), which returns the bitmap
size when no bit is set.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/booke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..9794ee6f7204 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -692,7 +692,7 @@ static void kvmppc_core_check_exceptions(struct kvm_vcpu *vcpu)
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
 	unsigned int priority;
 
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_BYTE * sizeof(*pending));
 	while (priority < BOOKE_IRQPRIO_MAX) {
 		if (kvmppc_booke_irqprio_deliver(vcpu, priority))
 			break;
-- 
2.39.5

