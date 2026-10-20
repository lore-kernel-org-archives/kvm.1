Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488098;
	b=JN9LFjpb9YB+fWxS8oWulrjwnF+BH1wolFNXzM0qO6hJm8561Q3GXL/Ap2v9r2Z6gkGa
	 Pz1sMlCpYvPYQye/AtnSaTdEfZL9E4Zyj/+AopInQYyHlT+u1QwLbzR8othHWsvmtm2VX
	 QBZteCkIofyGPawbymWrPnKKzwigiMM4mRlpocCQ05kTHIPnzXbyvbVRUpb1SGc/Dni/R
	 uXECofKWToqnwHXTR5tj1L7mZ4h8uiPlBv9aQDec5GxgFfTooh9wIidKKEOqfmjtBlwwC
	 Oxv82tZm8nM2ZA5bz/XZixjY7ytgR4EJoDvXa9qaVH23tACmm9T8HRg++7PxN+NuAlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
	b=MDz20VtjwLseR8Wc38EJ0i1ddS5eBYnFOGkqvzLdfuQVqmjNfHbnrzydl2BGiuSN22m/
	 oXdWCjCkdBWiWfgHVmcRODxsQRsaab2LulJ+lDFauCfZji1eJcmmPZbfAX8Mqgjx3F5Q4
	 VS9k/iDgH6sKGW86EfI07QApSH4v2Bw9lCb4QSpBTO/PKToYHDqPvHCda24EOHi0ThBGE
	 vsIARcAJNAWsXq2AHKVz3JwGE2Fi64Vv03HqIpchk0s06SZzYYbmJinyI9ekxAfnrrkoC
	 2RZhBL+dIlI6JMLTxXeFBFeyQD9r/GhyyfuA1uaxL69/Xo+cmq1HpxNvRGPNXTjec3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnlX8hbn;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB6606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BFB6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnlX8hbn
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2472459f8f.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488097; x=1793092897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=mnlX8hbnDVujAjRfxHok9GymLoWmm6QQmreatYfwiSqmCGOo4mQX8F6IOAfF1Pqn26
         rzCT2PlD/LfYRDBemmfmSKyVVNUms71F2HHScJzPQ/djzhxLSKegU01GRzTSDxzrLB8i
         7qmTu9s2S7tIpbfXzhAoWJiDSmXm+xeJrlhgVBW4GnK++N1xgfapsWBcrH5aU4Bf1ogH
         wrmXJIjqQUq42yPPqZ2s2wA1N6DDoUV/zrZJR7uJ3VOlZY2joYtc6cTRBl5zcYJTo8sX
         Krb88W9kMQxaMPdohOeNM7T+p6qXoORre3KBJjmYH0dNckbVNQ+VIZZodPIvoCoftf5I
         8V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488097; x=1793092897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=Y9KoMy35itNp538MnmathBIffcotyz4fcItYCmfNQdw7vq75p2WGID/OrEH4cNMPb6
         agoiYLX6xz/3TdGTTL1r9qLV1bCY8vLAZWqgzcAgWlcFcCtLPKQBHKlkBYGCJHSc3vLw
         P69osaZ0BON4GJn2+yZqHmpWV4PbiqkGDTO66E7s3MAvfuclZl2aqSE8f+e5grNYT4Ew
         5yyEms5Y4ADQJ4l6KAarL584nhKtwi6eZw/Ja560YnKV28wJ+YZOw+W59QyoYClSQpOM
         QFEgtByKzalX1TFr60KguzA5o30SW6CyTv14mCcWlsRTCb/2VaVWPpOsDh0xHZ0HyK5e
         e0Ug==
X-Forwarded-Encrypted: i=1; AKwUvByr9S3mZTL0Zt7b+2cSK170vXP874jHxOEr3D1SYFHGTQ2qofuy1GvD8Q6fJHHmh53wbqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkqK7yT/3+S19GI1I76FOwSS4qYDT/kAQ6u7UfyoBXFLeLdBgU
	i+nn/H2i5P7FlHU2xDQDHC04gSiqGYnbFbivppFMpVrW8WwNJjCAv2Y2
X-Gm-Gg: AYBFou0zllGBolfvTsneCKbwi3qqGjNdOoQgaTH/EDNxvw/sF8MDqxUZZvb1wPVbrXm
	IoXV/WXlVnfXY6kkDa7IUu3rZwGB0f7BKibAsVxmQLyoHdItt57u0yW4hMbM8LvnSY/DFOawa4U
	ETLchAhy3fhAXhbuo0A/ptV8E1sBs8LJKJTdTV8t+UCKxVAIEkmZAXzSOd0J5zdRgiVkSa+KBhM
	R+Mn3ontl2d3AuCaLw3ZGe5bPYF/PePKElEE5jiJ5Yjau3ZnXnvd1YhQH8D4TRjj7+KwEf6o9v0
	DPG2dOs/9pyXhxbxNMO7k4H4dK8mlV6BcfsbAwYL7BvJnUMFiuAv6PasHf+pIVTUnpa2xm4QiUu
	3HicrJ0zVc2EDou5RknbyC55iHwjRMBEnghOoCDadXnBxWs7z8c5dM08pvVkiDu/lI/0Tt61gaT
	0UOv32IvD3qQBnka9t8tWrfc9PMdM4kaQmhmbUOJgisn10yBTMzhg5ELr/WZqY2QqhUNV/Ns0Vz
	ErOBiGpzTF0W/Y/XLXAJZ8To4lA45llrXA=
X-Received: by 2002:adf:fd4c:0:b0:487:27f9:841 with SMTP id ffacd0b85a97d-48e07fbdfe2mr15044578f8f.54.1792488096337;
        Tue, 20 Oct 2026 02:21:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80f9b3sm4629943f8f.20.2026.10.20.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:21:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran
 <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020102134.745ff48a@pumpkin>
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
	<CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
	<20261018174250-mutt-send-email-mst@kernel.org>
	<376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
	<20261020021924-mutt-send-email-mst@kernel.org>
	<CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 20:51:43 -1000
Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.  
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.

There should also be very few (if any) access_ok() calls outside of the code
that implements user copies.

David

> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?
> 
> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus
> 

