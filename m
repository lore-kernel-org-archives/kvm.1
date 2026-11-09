Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248128;
	b=ckKswA2aI0gqNilEUPI4ujH/pg3oMuF1cEnqR+mL2T/HKru1D1mANuxHzJi7+NePcF2R
	 /YWeVkW3HlotifrYzlHBPD+5dvBRSVGMAl4RQWehwZO6phjZ3hRE0XAmrOKj35qcdFZnv
	 9id+CDvdZEvcTnP/2aEWRYukUOvH8k6hGOMGgVwiaVre2qnx5Cff1OMVkBwigcleJmp/j
	 9ooGRNxXhWqCVVEj+rD8kxGJOQ9w31TCAjGnyn3KBtAWdweKbEyzyNdrkdgkbnsmz/PhB
	 NMLmcJiK7GjFiz7jX+HZm48CWImFWzZnt7TTJ7zxTRrHprZC8wf0Vys5kElKTPXWjWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
	b=F9AX1uUjmARpWwPPp8jfjCVOi1InOx8Cw5V6EDUDomGRtw60p8QKoK9F7soYjYuGYzFW
	 k2NJCngSlh5MBqYPcXCTdak69p9eAJTS1W8xT10EvG5KFplTDSHc5jpq5eKvb5gVRHTSy
	 kdUNlgRrIXIb78+Wi26Uwy9Tn0gKOtaDVk5XwPqFIMLtkq9WYOqAJ8KckTQn22LcPIlHV
	 e0dA/u998zjLc5yXyVnaIf09hjK58ibh6hikNWnf12UrPfDllR2eR7wQsiER6ZZdGoAZJ
	 Uhe1Hw5S1pvs4lQvEWw8ZiDXJldEqAYFvD4CrOOjwIHDu7GVlvWUluE7pt8PadANU5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HnyTglw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CA606A334
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 135CA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HnyTglw
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab27e45e7cso8790241fa.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 10:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794248126; cv=none;
        d=google.com; s=arc-20260327;
        b=XnGISX+fHK2lVIjoKNCwiMeRWgHPUatmhFjWuLuREYt8547BaIxXBim7sxGAyfydW/
         m661HD4ERAXfyv/ST//PueThXTpfGk753WiAeqlmVsOJGCU5ldDVCoxTe5kPrGuSqgmK
         Br113/HVfeb6k0l8gvElYNCUEyaDSXBYF8rJ6/40aRXT4HapQ0Ky2BpwQsmFMomPwdi7
         Yv89Tz+a0FN50/YICHkL8J1tu8cNLLPsXwVXBjJ4Qo/YSpzWVqvLLw4zTGFJq2k7WQAn
         zUwxlf0AFuLJrZS9A2p7a+JbTlp+D/52LdiIsA9KkHN7Vk260PVb1vL4Z9zmrbQNkH7X
         jUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        fh=JDGVSAwhQKeQN1PP/9NjfmZfla3Ufz3f18oLRiL9zp0=;
        b=k7YnKb2RgEw6qDyV4fGC2zn+vqSu1QmKeXkV5BqvFHfjcSEepHzGun27mAKdTQ3Vw8
         XxIV8q0s1xrZuiLHSr7yGMMpy7zLrRo2hCxqkuh8ts38PmVltyf0DNtVFezbBA7/4zIw
         b+jNpKuANccZBKGJRRZvY0rZ2a/8lmKh3gGZywNwy33SITKpmMlzNVUHU+3zmukvanhE
         lvj0ft6YejZJmuMEhUi1Jq9cU0JF8N0K9xFCGNNvB0JcLqd3Rp9ZeLKQP+h7lbU/f0wV
         eP+ABIC70e2ssi30OJWpEaJq4OcNHG0TJASWdyg5hHZ3YG8dXIs5Sg81dW25ILkNl2lz
         6Vrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248126; x=1794852926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        b=0HnyTglwTAL8gX+olVe8YavKHfLdVCs/Be3jlhbF7fiJ+BKhmXakYEsD8bV87zN8LX
         5baMSU6AgQuNEbABjA/yInkUpowZckQGLi5G7NdLcn+Db94+JHJKoSUatxJTey1sUiIT
         6Cc+a4BNwjPonJI5zoFYFSoxlc1OZu8/khdxk5l+nlPao2z4j3MXOPeLg7Qz3g9rmbxG
         lT/Pzdl4hmjyBx0aKYC0DXlFboMzZFYWltciUjh9KNDjKugvCvNkvYTc/qgCopKva50A
         j5/Z+wgveMoD9+aZ1FlmXreaQ+MGFHABZoYLDgqSbjYDrI9xXqGCmseyvdRwjNtX4ois
         LlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248126; x=1794852926;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        b=QYgF7mejpsOf95JBKtnY//tC2HlAlhjlMxojLFt42tHHUlrID86cgoJUtp5bHx/9Xn
         NZScTeq6cpkVPCfn2Wo3+DWCkffQE+MOm9IskzIoBpYIqvF9YkYm+uTychOUiF9PAGkF
         QQgD/PGXzq9tkAcUyWLixD9HApFW5AGCcZlgDrg6dDNJwBqA3nMnCJK6hXE3tUcDNpdk
         er/0a996gfgR5se2v9MGEguoHN45opNBsKUhJjvnMUgvhbj5Qyj1Bh+rxNpifmgqPRMh
         6N6etyrb4g2qQM7vhiuQEyxOGoa2YF4enAaYvRM/0GCfxKxw10XOL8em8s2jOU+KpvrA
         Qjxg==
X-Forwarded-Encrypted: i=1; AL+hErFnFDpnGXlvBTug7BTiCBYhyXeUCaFTGGjqBqTHrXqGyZPxj07OBelYpRxrtD7YzZpN/XU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/mHaXyKdsuyDJ3U73BdLwqnGDWNhKWCvpttIWqwkyzevlmNTY
	0+7InxqM2+avKB/Tx1ub70bAfrIyhxXFJj2Woq4qG1RQXWP9n3F1zRiaNLAsBpY5WPRwsaPfmdi
	BNN5ImMaPssiK2oFPTT9nbnlpaml3yvE=
X-Gm-Gg: AYBFou39NARND7WyqzCMmfkWCEyyjKY73jrPFzuoVcX3sNGHTZJKPMSNiVjRDr4UDQm
	Q8aMz29/Hn9iAxpT1r1cZFCreM2Vey+Vuv69Bw65FQVjtgNfB/+5SlUIFm3LyYfxndKnS3e0X+m
	xtYXiK3O1sF0rQJsX9pn9cMnOzx1LxiWC6spIHk3sISbemlOPDOjDQDjkN24eto8e7N3V+OydZT
	+9Du4hc7pR8Wu8/0SO7kKLf8R9EC1n2cKekPmmnYLJ+aZQaZXCQIshnGEjgeXCGkSjZyA5cBLWb
	kSjdr3KVugmpjE03XZiDywyAZYN0dla3nMXHMV85Mm6FZHnTQL3Y4i2ZnyBEtqvyFyo1a9a8q4h
	TtfP9BfOU2EI2NviWxkydlFCR9wr0oAZQ1sNxfPYOdiJ8s1EhBn5979lKVC0=
X-Received: by 2002:a05:651c:1991:b0:3a9:a1ed:6341 with SMTP id
 38308e7fff4ca-3ae096266a2mr129721fa.11.1794248125851; Mon, 09 Nov 2026
 10:15:25 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106191029.469837-2-oss.patchbox@gmail.com> <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
In-Reply-To: <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 9 Nov 2026 13:15:12 -0500
X-Gm-Features: AclHuK-kA47IWOIX7U2zRiO72EVz0LSCPAeXxYhlYbmsVsJrtKZ_L0q_mB3RhFw
Message-ID: <CAGG=RgDu7-3g1yTGRYukfhpXnPgqE5BDQ_cAzMN=78QiUrOykg@mail.gmail.com>
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 07:38, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Does the the iommufd backend have the same problem?
> iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
> WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I guess.

Yes. With iommufd, vfio_ccw_dma_unmap() is reached through
vfio_emulated_unmap(), so the pages are left pinned in the same way.
iopt_unmap_iova_range() then retries, and if notoper_work has not run
by then, it warns and fails the unmap with -EDEADLOCK instead of
hitting the BUG_ON. With the flush, the pages are unpinned before the
callback returns on both backends.

> > Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational")
> cc stable ?

I'm not sure, so I'll leave that to you.
