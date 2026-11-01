Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546925;
	b=ca7WPqiw2HJzDqlq9DNAmRT+Lsm26WYYwhOFRExY5JQbEf76H3+Mk8SWQg0ZDwEJd3tP
	 KIlADGUSpNFF5P3JcMyamvLEYogClNfloMCp7eH28Rju5sJ3+zjZI+hB/m8hT6mA/TIml
	 J2d6KEy8I7SK+ugvZzaE9NQ58BLmnGs3GlYnhbPNHXO276Io4jjUam/B5YZI4xBiaev4o
	 fYh3p31Wl4na/YKaY/CpukIBHq/wxesiivFS9AeGmurCH77SwDlsrb4uLm2Hq+osmU/LK
	 J++WA6arRM4zqU7FFEk2hKzj7djZY267irY3v/XzC2FDd9kfmY/SrRPXW0Lwr11c3Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
	b=INjuEYh/Iu4Ngl2WN3g7vZZr/v8MESl69GIxlg35o7KjIPo7+BuU2ESDCFW2zEJZRHMH
	 4FbIopdmjBa9gh4RIe3Mr9+ACmsBb268fH6QqF1VDjNiAiJZcS8VvZuKoI8nASkP1Wmil
	 lGW86WR1fws95sch6v6NzMizkuuAsFY5Q6ZrqxyXoiBIadvLsJQ/SOAKTQZgOLqKy1n8D
	 Z+WN17nDCtIQVxW/6ZUxHP9ktuVnqCNQSSA+/e2jYKbBgG0imURrXqh9P68bQ3GNQJvZt
	 1uryvyLDSlAJBwDMLJGAUboPFKGOfTijL3bmvc3DdEphuSzIwGOK8G/UkABVQJ6Vypw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+W7JEtw;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCA606A325
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECFCA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+W7JEtw
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso2953144c88.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546924; x=1794151724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=B+W7JEtwvAB+w3vHEi5aZ6qBz/STLM/ZquA3igTgLD58zdAVdC8c/7EfsoVvMetKFC
         wW5ruwtnd4VYRUqztvXOH3Yt699LwPgK3y/Bs/ipxck0J5Ch4OPjSaMxRqH2nVRgZ9j5
         n+qc8jOvIscKPcl8CwAcOCOBIoR6fXXLNtrNXNB3wHp/b/eS/yMjOzOSOSAY0X3ehJrY
         8X7uu5JO9WA0o+Y4YeSHrnb5jbRru5IMSz7sAWz3p82Ip5RZih1n92gAX1XWYk3TnZR4
         wb/OtJKkBOadV8J6vlbNMmo+0JNCP3zjLDjfRVcbJ/YGXvEAL5+3/23XW3fEYQk11Y3d
         Z9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546924; x=1794151724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=tXRD3TfKDZgNnH6aBys4nTPdrroiOsC96l9RxMe58AuN2z4+Xu7ATJtXuW3YsET0i0
         EDaTqRPuWtTdS3b0d4OsArl7RMxfUeZAVp29H4Dt9V4ap11ufvkDmVUd8xJDTYDGu/ye
         vEOLXg2sSd6buj4prbxZdXY/JH3LTyDVEWYY4iNH79V3hlbH5SKP73E2AV8xxJAvZXLX
         XiF5L/o/D0N6djayD1HVnSQu4y76/LGktm3v3nxC3eELsvSzW8yeK8ZwAtV0sv6HX55Y
         2xbwaewA3hOU5d2ZjtrEfXR7COpAZAIJUY6nRzvmall9UBMG1/wKBkWnWdyttNP0pviT
         XK5w==
X-Forwarded-Encrypted: i=1; AKwUvBxmRty2dpElcFYZCnwiFOuohGobmtSK8jOfLScFYpNelzqMARsMCoW0DgekHml15NiPngM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmkXDV7tP+vx7Dne9AhASx034vxR4J8msfKZW4vVPBw6mZSzSd
	79q/t9vbp8wkAqk/ytZmf8k3sxi5xFqUebUwfYWqmvr9w4o8RSzB2qE/
X-Gm-Gg: AYBFou2Bl7nUXRfuTbR2sP8GECrmJEub+IHhzbI6b4DC9yzBShyfJb677P3pFGwOKgZ
	zrPxBjpxPkjRUIPm+FBASNfLDkZrsQ42K4I+XrlHWU0GAmYygOFhzunbVKm/OW0d/ldl7zEXnp5
	090fIi9Fz3gqtcjOIhEiiGvyW0csqaitpzq0bHKTlD7Nycvlpz4rGxqVAlsH9Xk9ThvtbU1vKaN
	ENJDkI3LW5TInOotuALdCLiOff1/jKQnF9uL14RKexiLkiwKMnkdQvQEm5/x54SuUW0RD7/beXD
	LcVRCwD1Y/hGHf2D36xEZMRE+G+63QSHByl2IUHoRBPkVzJJSciNT02z764brnDau4l2mtWVlDv
	4AFgF4vRbSeDkAlp2bXzCEc2IpNJFTbe/EA30ATCxTZsSrJGB1th/izDGgQQ9QC+LZlnMejazo1
	WPdr/+Rg/4xIHX5PuqSpn7wvW5JDz5PUZPI+OBUyptQXbw31bZ6SVzAXSIxgq4VKc/J21J8FC3y
	u36kw0YycA9w1aDYBp72D9mlfKIfYsF9ZMo4Ah4quin1mOj7P+c1rjwtr/UobVA/aLf7L9B6vEC
	qwxIQWYOW2jNLw4xPQ7uARqBCYi5BqeE6g==
X-Received: by 2002:a05:701b:4784:b0:165:4b88:abc2 with SMTP id a92af1059eb24-1ac5b5ee632mr14506105c88.26.1793546923991;
        Sun, 01 Nov 2026 07:28:43 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:43 -0800 (PST)
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
Subject: [PATCHv3 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
Date: Sun,  1 Nov 2026 20:58:10 +0530
Message-Id: <3b233fa135d54d3ffb569d7febdc1cb8e0ed406a.1793546707.git.ritesh.list@gmail.com>
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

The previous patch caps KVM_CAP_MAX_VCPU_ID at 2048 on nestedv2 but
nothing actually enforces it. The generic KVM_CREATE_VCPU path only
checks the id against KVM_MAX_VCPU_IDS, which is 8 * NR_CPUS on HV.
That means a VMM that ignores the capability can still pass a larger id.
That id goes all the way down to H_GUEST_CREATE_VCPU, where the L0
rejects it and prints, ...

        KVM: Create Guest vcpu hcall failed, rc=-56

...for every such attempt before failing the ioctl with -EINVAL anyway.

Check the id in kvm_arch_vcpu_precreate() instead so it fails early with
the same -EINVAL. Note that PowerNV and nestedv1 are not affected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf620b6534de..5f9cfc34bec2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -778,6 +778,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	if (kvmhv_is_nestedv2() && id >= KVM_MAX_VCPU_IDS_NESTEDv2)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.39.5

