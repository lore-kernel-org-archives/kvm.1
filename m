Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725582;
	b=fedW7e6fBgSxUvSNJmPz5s4Fzme7GOLHjiZM2rU1PNb2VbLL/KdyDboTos5EYeWadnD7
	 LN/REleriQNBY6PWtOoR9iWeoqpYXoXCX7shd+N6rY4nTOi0f87l8yDN2fqZo8/M3N82u
	 g1JFVFx/Zzkb+LDYWu7Xr5JSqyVc/ZDh5MQJD7rOWJu3M4e9VyP3B43N/HL7WbR/FUawq
	 h8EA2/ro875HXnEL44kYrmN4koEyISqDXoXKg29Zd4Zk/b28D9kpFvtDmkwRxw2uwu4nO
	 FHtQxdS9aT0nBvxMcpU72RO5s2lMeQLERpcYc8eGPAs9s8PDk6tuyw/phX34Hq9GE0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
	b=BJr5uFNIkaAM6p3C9q/zUJJVZluJK+CYGGvb4Qo7bztV7rr9+mYeedlVTeSTmf58Fqdo
	 eqP09fKZX6lm5TQgnGv9v6a9jnxdDPAbgVfmFAyvMHswm3mD+1JdIadX/p8smNJsLr0uX
	 x9mTePmwNsxQK5EKY28gOqWzhvWmWNaCKj8nWk2+qP4ghfOEp4ipvaUmSBdR4PrC5ly52
	 YXf1U3UJrcQMReEDMcEO5klaVPOGB7ueDURILbARWiGS5EHKfsR3i5MvG/jeFu31JYwdV
	 7jL9GlSX/LW6tuoQq7j16CeX9kgFE8JhKjjdjy3MrwJWXltLzOvLc3LF4yEqZb/Y8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTFclkNI;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF9606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 17:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EF9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTFclkNI
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a17a332ecso6655453eec.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725581; x=1794330381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
        b=MTFclkNI+FCsVBl/mLmb51jlz0nMOwDYOXbc40iHx1X6ljDfPHKznHMuN6gZxZ6Wlu
         XkQAKVw6f9Omx4+2eA1nCivTzM4pmB9xEhulfvNl5/QBTn6GrwIgdv7WsRk8H13Moe7U
         +obauVvQhJBG+PpFcphlPYSbHiVQXKApsl8DtMiKvH7Q8zPxvsnRolClpJKA8EtTkaE9
         vEF9ftIw0HuDF+EE/zTlAKPYd09csicwlM/+AueS2Dnf71KRAcfEjblLgFBcSWvhDdvV
         365jvY87BgNcxJvs0VyVlayKHFhBC1ZUgb3P/RPbee4fir+Q+C4L5wPhvwBCEP1X00Tq
         T/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725581; x=1794330381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=59iGDOcne8oZ9CQ+nnh1K7KAR/IbzmaK4/PRVFsySsY=;
        b=FKsVNAaJiRnE25vhRiub8PNTjL7fgPKGb5jENJKJqd+AgaeMF4iHum2qexCMClwkVC
         WZ0X81I4V/m6Hg/DD5CKsmAM//lc8PdNIMZDg/hLOVpl5cmQcyt8+gmX7/zOih2eLG0s
         KvVgIaevMnxr2jHpF+ptgKR+egJkpimew3YMJlyxdOh8foPWJBX57sKX+41cPK+vZNol
         5k6uMDEOXyktEhsFDtBfG4Sa9oHUaOpm184EXdvltsF0l1vNvdCJfPkSipXnHz5STgAZ
         K2xzJ1QY9EwwSZgIIbIoylNOuxroO+iZqE4F6U175n0eKVOQgmbJhd/NtunYWTYOOp/V
         aPvg==
X-Forwarded-Encrypted: i=1; AKwUvBzSeC5p48HMY+m+CTzIFUSqqEW5Dg+Ljj/f8ISWmvtlhoaZu59pSJrcsAUOWiDHwm0U1qg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aFSd4jxoyA2DPL3nvDjtYBmXs5rXNKhjHaHAKfg9BFhZGrUE8
	RzTTHwCj+bRZGmzuWcetYVIv+0YXg5l3t+HIhzTELRg8qlz4Ie7RUQSk
X-Gm-Gg: AYBFou2L4oav/IcxlmGfw6puBs3DjrRQCeFCCLw6RvXWx2BbpTcEXgTyVFXa6L2XkTe
	pJWhblbTEueIdz+mDyrAqma2UHPv67CdVAUrgKzaRAipIMhZniLI0g8cocvdrAl4jYhqA7bZiic
	t/+XtuNyhUD0bwoRF/FtoRNVTfh+CipiVPsX1ZHrRnXZURi7kxJ5+DuON0smdR8Fqm5/ZJSMji3
	Ah/KhlwsqnEtHCaeIiG/VqyR08vPngMjWWCxQ7t5NSCHGTpxL0A6RZA7OQQwb72ZvlFCGRsxNAP
	S+YRNMAjeWeZ9CmsS8FZZa5UjYE0OvQf/4LESXcUl1Zen+G+pbj/3530jGm8nAWht9RKW2lXWKp
	Wo0oVPQKcEUYmWZRQhqzrLyY9fB3flbgKwNLI7yk0yT1QS61Vgrz0omydPofwMQ4DyEmpuTwScX
	bgM32JsT4X5tgxXURm36qFhy5DbCd4a56axV36XO/1nJeiVkN4QWTI/nWVR0lG7naiiM4CD/TZ6
	4pCF5g4c3eee7QTyjASaw9wsk9GS7n9V2ochWjC9yX5VROTIBayCIeSCIFU50FG82e4zi/igUf5
	hl1ipV/1mt5SqD01AoKAtENPv90V4uJVJ6co9JGcDKODMRLJzsGu0uHy5dV88g5bzUgpC5WFJzE
	yncc+x3493/PUgV4dbN0jY4D7mDHJDRG/YRDPPGM0zyuN7D2+PmBlUfjcyd467xZ4n4SS1let7i
	o=
X-Received: by 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr9285160eec.12.1793725580459;
        Tue, 03 Nov 2026 09:06:20 -0800 (PST)
Received: from LAPTOP-97G9G880.domain.name ([106.222.203.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm49661571eec.21.2026.11.03.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:06:19 -0800 (PST)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sashiko-reviews@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Tue,  3 Nov 2026 17:06:13 +0000
Message-ID: <20261103170613.162803-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102073033-mutt-send-email-mst@kernel.org>
References: <20261020182640.2048506-1-karthiproffesional@gmail.com> <sashiko-outbox-180555@kernel.org> <20261102073033-mutt-send-email-mst@kernel.org>
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

On Mon, Nov 02, 2026 at 07:30:54AM -0500, Michael S. Tsirkin wrote:
> Karthikeyan were you going to address this review?

Yes. The leak Sashiko found predates this patch (the same loop leaked a
put_page() reference) and is fixed in your tree by Jia Jia's
058fc59326af ("vhost-scsi: fix page reference leak in misaligned I/O
fallback"). v2 is rebased on it and only switches that loop to
unpin_user_page():

  https://lore.kernel.org/20261103165917.148720-1-karthiproffesional@gmail.com

Thanks,
Karthikeyan
