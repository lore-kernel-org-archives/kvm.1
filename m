Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793231614;
	b=MOi0rp+FSz9LG8KWNeoCgeDeQdlrBLovuBH/3QpyTyWLMO3XqSHYipBnULIJ84b/5K5o
	 RYi/nFUMIsck0jkdddu9VEfDcC6AmnAFhYl5tmiz4PasA8elC6WnImTdYKcts2Ls6EeQe
	 i8WPj5DOWTsODa0LKSD+XCSgL7go8alG7gBubRs9C7z3KWqxXPVz3ZYOHo99SfHl1KATT
	 VcKjyz3jDv1O7lNNil+lk9MZBgzxKzJfIa6zYRmISkkVCkagDcBsi/gJkEOTYv/A5ZUYR
	 LDr1jKZt1+E/KzGuT7AYeE1gIB+VzItfRrsru8omk+mPlrsG2+9YP7eAhCi4AvrnkwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=Xf3WpLpXOd9QYLR4dzKoF2rSwhCdMC+MRZJA9cEo7i0=;
	b=BLEITIzVfEcaK75sQ++y+LEL3/mhGLTCXoOmva/A2f0rjDGzxCaJSzEh8WD+kh/6tBdR
	 uiMfZZiTpGhuo3P+pTl8dfwwUJ+TGUeNqRXoOtOrzcXQIW7I5NECB4kLciwq2CvccfERv
	 ttjQP/04V8XPzTf21VTDh0QTyGvu8Yv7Do1z2bV1zXhxYixK9LilvtYkBRi5A+B7JXAyu
	 EEOEHXBXU/6oCQR720F1arykchCrfRMDCVcdcrGcvitXPZcqT0SHmcTSE8efa+De525mQ
	 Zadd41X+rOixlL/PFGP+YDtsSLmnF8r+kThz4st7n0ob7CdGjqNnOdz7DlqIu+XyUzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PfJkQ3En;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB01606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 23:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB01606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PfJkQ3En
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53634b8328eso14709201cf.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793231613; cv=none;
        d=google.com; s=arc-20260327;
        b=fXwVA2m2RNZEl4wd4NfPEr2nXLoGMxhhH4NTw8vFVobLaim+jq/W47++mou28fG0TN
         qYfwXThPIcDLwiYpIbiLlbT4X+ChtVDKo5q5JySXtK1uPq+TiEq7dLntWrf+/mMFIi8V
         zaYkd1Wt+jsYgEI8V9WgksgDmXc+CvKm6djVxL0AhCaHCM3tSG6p5Osv7KnZvwvHnp33
         vLKtWTWwY5sXYgvDCTjtWt719FL9gnFQwzO6VzqShcAifkIwEPIOI7QC1JF0ftENdz+c
         79S+Aa6DQSTbi/0MCo36XVoPmBTaMzhgKu/02fODKZ3EsHYqY7j+8WFdVCawtKr0uzzj
         yJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=Xf3WpLpXOd9QYLR4dzKoF2rSwhCdMC+MRZJA9cEo7i0=;
        fh=PpugSerkSQ6BRiqDd/NxD4nLXokIGKQR1XuD8aHQg+Y=;
        b=EPA2A+B4n0SZyZaYSyBWvXW1iXbAq45fir6DSMKxVE3X9cEeZf/78S8VsohCFE+tG5
         aZcgQdngJyXHb0Lv8mcXvdLeAoz1EsB2grwNc51mmdL1dCCVuAyGBLJsPg5GW6dQ5iop
         S5YyPErNeFfB5czXdkSuIU0eBze3oDbUcVdRLIAKq7fEaJXY/B00c6XPNAwYIZCjtbGF
         PJaDbxaRjEX+uPAgG2cwqxnPXLycvE6bB/KPPeWBuQsBgY9ldjBCEMMjsPz77uOQkpBW
         ngGDFeuRXnffc4F2/eneKlx6+T8OSDy5ZYIQhygkQSayvd9r9lfmHsT8zFSUW8Ofri67
         yJ7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793231613; x=1793836413; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xf3WpLpXOd9QYLR4dzKoF2rSwhCdMC+MRZJA9cEo7i0=;
        b=PfJkQ3EnJAW3DTB9vo8MwmI6tza/eycyAdwi8YG9gBg2kPMDayHztb04vf9B4UkBJy
         1+4gfIB3EC/gIet9lczNtsDshf3jCBUyfLtuWl63AvzI3ibKg2keKhA1S9hTpi/XUoDu
         F3kKpICxWVOYAFLfgNNsiwDtdEc14jAfX14uMMgWxzrtJHONTgOOjXAyaSP+0vIInrHh
         +8QV5mk3D1hRPv6feJEEJnTp/hfpqJWLsKoiUuOZiTVfxc71LSyXohIFW+/ONqvyqpUK
         QSrsT0f6dnnkPdGqJIoX1e6IvfY4pO7XmuHAt1kOb4FzKm8lxsrJ4YmOdphc6fbdudrw
         2H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231613; x=1793836413;
        h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf3WpLpXOd9QYLR4dzKoF2rSwhCdMC+MRZJA9cEo7i0=;
        b=Hi3oJPmFl986VH/PdeGRtBlU00dWOB/RH/JjWkOUSwScH7lz6HNCWibsImHfX5Oi5e
         QtHPXRRFiioN3QcBY1EV/aF1zv9n0dc6PjMRWYhFm0Tuv/UF0t9CT5GX607dVO5mfj80
         kVZMOK824VK4mTY3PIrgl/F8rbsbLxDobdD5xTXr4ukI34RS4pSCBn77VZS8QUB0wKbL
         vh7dHQj2XSaxspl8gwT/duo9MJWAzH+n33nAIGBY4JvmltlUDoKJd+Ze1Wr89YJreR3w
         CgYA2SWqGsO8KO/E3LWxAQIUXvWS8T2kiTyo6nYB27heIIRhW5wa5F+j/2AwVWOXQMyr
         V/PA==
X-Forwarded-Encrypted: i=1; AKwUvBzzKJSp12MKH7tcl/zTMzU0Z/wdSprJJrlMHWI+wFV/sadRcpQ+73TPW7hilNMFwX6Dhr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHVj1YpMaJ2FDL+GwQ+HXD+suqjO9/EYx8P0FSc/Z3a98dwPRa
	beT1jZ1F0da5qoh/0tykN+0ClfeB9VgW+7gTI5dt3zqMXjjEPrWeUMeWOauffzfluVwec8Sc+WM
	og3c4GQtlfVuDwwL9h3lgaIln1RHfCib2HcLq3XAW
X-Gm-Gg: AYBFou0C/Kr+M6hStV7pfRaY/uN1Zg0Rb475ByhdIyORCmMvTOVJ25qTa+AF2IjUx7w
	QQWlxpsjYyMGeUheEfwG1p5b91ZQVgWr2Butu8JS5J/rzUZJgJ5DU7FaRI1bcZg7h0M5xkWUlWI
	3EvEGi1oaC/MqP0lRwzvzy9i9xEhQj3Yb9vZyTybzNim6jIaV1y164AdSBcwePglZZu9qmuLLRt
	wyWCr0tjavMIxz6JMOAKwBZkcHKnrpu4w9j0mct6r+KFg7MSx5t9CR8H5cRPX0nOrN+FAQKw1hD
	EQNFjFSt8J7W0JwHGFx4A85y6+7KJrOP2kOw5yzGc6dniXOrqOh1Z0w+AbOioGCLwxEItMz+nTx
	n2WXsETAbSbq36yX8Uv0YP2agJfPabmvec4k6IqChoPKM/PRWhvbGEbLPechVzcmgoc0CFjKiM/
	FAPJiDcQ9a/z7mDFBcgSOcuAs=
X-Received: by 2002:ac8:5dd3:0:b0:536:6856:f590 with SMTP id
 d75a77b69052e-53fcb5099a7mr71999251cf.18.1793231612338; Wed, 28 Oct 2026
 16:53:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 16:53:31 -0700
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
Date: Wed, 28 Oct 2026 16:53:31 -0700
X-Gm-Features: AclHuK8fEnLx-zmlQH6Ok-lGIPb5dW6dcApY-4tFErjZ48FFcbY1Het0S7rgZRo
Message-ID: <CAEvNRgFaNnCHKe+rbGkw-BwCMoHzqw1ekUiMcT=zCh1TknzMvw@mail.gmail.com>
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-10-29
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Our next guest_memfd upstream call is scheduled for tomorrow, Thursday,
2026-10-29 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.

We have a couple of things to discuss on our agenda:

 - Alternative memory providers for guest_memfd
 - Quick update on conversions

We'll be using the following Google meet:
http://meet.google.com/wxp-wtju-jzw

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want an google
calendar invitation that also covers all future meetings, just write me
or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

Thanks,

Ackerley
