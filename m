Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124844;
	b=oBIuUrilMjowrnJi/HiSNDjiuWTx4Mq+vowcu4aA3Kx+6ESUVnJIe77v/cjJA56gAGJC
	 Vwtsg7rbRfBaKzLqInp5V4UJb/Y7V2+CUouvGzGWrB1nWhQuw0XUVtmDZBi0k0CFAp7Nr
	 3xLHIwdJx83KMoDTeI9oWLvaa3cCK05lnfzWepNsvxoGedZcVIfz+c/yvePOKExOQ2Yrz
	 rIlykr4Ez5xR4SsAcHXyRTIZDVLDm80ZloqibCSGaFKHroeVxXdu/miuVJstgLl4Y/If1
	 hsnbPCQu6mrG1jCkbTc2GaYa/SwgAfFvPzIhgc5qlHSeGk60wmTLFLNb3jKweBzCDaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=L7EofMK/Ds2aCpVQ+mBzdmSBmTPWhoy8WE97V8cVUk4=;
	b=TUX2jSzfoHHLBjLZrCfXUn56/qdDyEr5YzhPhb0sMk0xyAqaEtYEIWZ6DpOECE7G3NIB
	 cyJkjLhpE1wzMO3sqOx6LKg2qbJ/DciKnoBWgHQg1qNsBsiHg3ctTc4fhuclXw1VHcLXM
	 GYIVPA/huEJ0UPNeGGFQWen3pGSogep8hXoCKbB0ftY1YQnrtHR1tTocQ16Nor1FCd7Cg
	 8JSwMp2hjz8hgNSoCvQteo0rNvfp40db8wxS0m8fBrDnQDDhoRMrdWA0Mo3Q5MS0eh7pu
	 jPOoPvEGNrzIZGHhb1V3WUSHLxS+0y/PFDxLUawjnr/3f46K5bkoiXjdmWQ8014pqCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhfCqjZ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E3606A324
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 21:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937E3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhfCqjZ9
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-92104b67a9aso3176396d6.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 13:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795124842; cv=none;
        d=google.com; s=arc-20260327;
        b=igcM9L2hCaJpokm+aTJhkU36UikYWyA+WErFDMo2nxYpyFknwf0vmNKnS8A3G+Qmw3
         aw7fZo1FPd2XUI4U+Dp7faa7gRcwi+yjrDnnTlvBtEcjqmiAGS0vZyKPisPC1JS9j+/z
         qGO6lI64lpGUF8LthQKk5fTHoSs9uQXmaKAQhwNpmDE3xUycd72o+Gt7ZPsCC1VpLlHU
         z0iT9OeWxI3/ryfzQW/1V0pRrELGJxVjn6Sz4ukwc/GJ+7k5B6uCsgHjjlyTLANNJuTl
         FdQuKOnL/4PuTz944d2Jz/1P6OSAimuPRnlBnm/YwZEesAn/kOdb+WvLGKKg08Ff5WaO
         3Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=L7EofMK/Ds2aCpVQ+mBzdmSBmTPWhoy8WE97V8cVUk4=;
        fh=MWDhOKLn0/JLwn5oyZWezoehjcgd92Ze3bFvq3M4mLo=;
        b=IL3Tb1e24LjLk9ekqAZNl87EG7UzHHAzDz8+F0JxWK+XV0sdfCjGo5iO3J3HR/93jZ
         RD8yNbBY6i8s4JZjTdXPW0rCmDASY5S8jtX7xS5LBq72oNVxjxl27B1Vkd99dvebH3ok
         p+zTokdH+YXJDvjRGlkekA5j2ziWPSsqregoXVkIutov76Tz3Vy8KfqT3mgA0maL8W7u
         +tk93gRgUeWujhguO5QW9rnA54JDcJSp/mp5s2KPxGiPeQojWAldaPXnhHIXvuHe+9lZ
         84+ldtQw/D931dYw2tUhjZBaOQIYYVAxr/6+bX+exh4ovlbu93T68je8S59mPIdZbIWk
         XjLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795124842; x=1795729642; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L7EofMK/Ds2aCpVQ+mBzdmSBmTPWhoy8WE97V8cVUk4=;
        b=FhfCqjZ9kHq0VM02oTsUQ3txYTYlT0QUPVw6yotQ4PPUYClDEqOk7micH8qS4jPPtz
         FfyzUoq6ggbBfSEtUkXT+sqwWC6ZadBE2m2edPu4zU6iXjj0GAFgqjM62n3ssnE2cZND
         uvnjXIJTIjrYhcL/nBMwghqrpkdUcdqPoog3cfLv+Fj+Oib1kC27gq6O7QJLMQyfhAkp
         WtckTKUpcinQCKll9j2wu4/TUjJPuDg4gj1CvNmirVJ2RJe+s8oAtaM0WoFCoUCAzHbR
         QrJS03MyoQf5IQQ6MKdVNIyKis9vo6tf2u5gPShqQLWCs8ig0orKHuemeparyp1wUYEt
         +34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795124842; x=1795729642;
        h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7EofMK/Ds2aCpVQ+mBzdmSBmTPWhoy8WE97V8cVUk4=;
        b=hKnNjFE94qREdwWOI8SJTryuJqpqI3KUHyCf4CrU5C+e1Z0Tq2TcPsSrYkOr9HOFN+
         1b/7YTWCPlK0TrB2VinVGLw04HsaNZWj+evGY6uBT/459stwQ1qBM1XHNSLf1r4lbM3H
         fdbf0KZbcOXXAI0pfp1mpj+ANc0+ztDk8hLKCNAOajtHl/cvDG+wYrH6rFZ/JbP63CbF
         ouPSqyowhrpkCwjV/AHgIwAwq9wpi6UiVw03SKJDa58XUh45a7mAVJWjKqAjIJuCq25u
         2XP7aMbL+2+5MV4Df41euWSyt55F7eFoSkJGgUljz3kgQBU/7jZXYpaetgIzJD/rVCkY
         KqQQ==
X-Forwarded-Encrypted: i=1; AL+hErF5N8uHegHKvguk4fMUSA1DEuPbt9gLiZMLfiQubK9EyfxhOMEXHwedjhIJoFnR2xcxR5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tf8FlAgtOBcAeHrKU0hsqOYuUQp+NW0N6sV2zP+ONdMJqaJi8
	VLKppvy7QRvyeKFwS07A88Tuhfpm4jQRfR70awFgbKe6gv15/QcymNjMEoePbysrEJh0BuEi+5h
	TMnljy4HZTD/2RlfSS/QEiMI5tPbEGosBVOZbySUX
X-Gm-Gg: AZFdTZdHatqfFfT8a23AU+tWX3OfNvxyyfn5wvYSQHTGTodoZBl4nARbi+DPu3uyZre
	rQ2oMhTrs2JqTsVjQNcZ7nL8vgVjrjcrdounnoswI+IYqS217zbjzcXZGUF6XZvNsBsoemnKxtE
	Vqkk66pi9aCIdkX6lERH/heESXfwjTPPvM7E03E+aoFUmZAPD8QCwpO+85vIh17rJg8OCfUM3T6
	I4EkcEufMNN/Be1rkOFLSU32wv/qW3OC4pRutT2vFno1rRlFJeVZpSS+Y6oxo4BXgkEy16szvkX
	WZubfqE3zzfrxkOGCRZfB1TBfA74sNtTJzX2vWivjeSEsHVxTb1GodPrFqKIZElRhhUK9bJskgT
	7XkzZwjjQN8CDYEdnu5ixxnfpGRGCYkjhM5zvPeKIhM/G18+hc9/ActjpB/ek88X0C+woKD6UYC
	AOt+wG/7prGwZixogWRr0m+x8=
X-Received: by 2002:a05:6214:460b:b0:921:3585:de48 with SMTP id
 6a1803df08f44-9213585e1c5mr10964386d6.40.1795124841760; Thu, 19 Nov 2026
 13:47:21 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Nov 2026 13:47:20 -0800
From: Ackerley Tng <ackerleytng@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 13:47:20 -0800
X-Gm-Features: Aa3M54rWsn9wxe2P3t1_p7RxahQjwFGHSbiMXqoPeTbRFHx6sSpgmtl4W0fkKbs
Message-ID: <CAEvNRgHpOQsF1E78uMs8OejSnNxWdRg-1_b-V56Z=kmotJt6fQ@mail.gmail.com>
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-12-10
 (2026-11-26 cancelled)
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Next Thursday's guest_memfd upstream call (2026-11-26) will be cancelled
due to US Thanksgiving.

Our following guest_memfd upstream call on Thursday, 2026-12-10 will be
shifted 2 hours earlier than the usual slot, to:

 - 6:00 - 7:00 AM PST (Portland, GMT-08:00)
 - 3:00 - 4:00 PM CET (Munich, GMT+01:00)
 - 10:00 - 11:00 PM CST (China, GMT+08:00)

On our agenda for 2026-12-10:

 - TDX huge pages (Yan Zhao from Intel)

P.S. I've also adjusted the time zone for the meeting to be
America/Los_angeles so it's always 8 am in Portland. (It's what David
used to do for daylight savings too. He's nice to US folks :))


We'll be using the following Google Meet:
https://meet.google.com/wxp-wtju-jzw

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want a Google
calendar invitation that also covers all future meetings, just write me
or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

Thanks,

Ackerley
