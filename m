Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6E22D7B5
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621181; cv=pass; b=XHmyMRht/oGUc/gl3UXPqyWY5bAsqm/Te5EqAD+YirR+tM1Sxnz/fIfJ1rj5/DizP33nD4Y86zFlu80bOnTW6jRaGQPgdq+qunfY3azIXl0wv8D4xtLDSRJTN28nTc8E5mXqj75zg5KPViZwGYdQKYXKBAG7tL+dKqd9q0gVCEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621181; c=relaxed/simple;
	bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWkt/SDDLYiGUAugBxRFt63L0TSs2Fr5s+C0tN9Yk9eoBDKIn7X3xkKhj/tzJgKro1n3VlZEe1pXteYzAKK5Kc2ae2x+q/sQW8s8Ypv7BYT6fRKALhvlJuCkCPoh59PMveG3Ms5O1EnMx0Rmz9h6ytxxEslF6sCyfQEazRtQwwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPcwL7XD; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPcwL7XD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so2186726d50.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621179; cv=none;
        d=google.com; s=arc-20240605;
        b=h9IuETULVKf1AzjqB1vO3Xavn/AKMzO3B1PFHpqFtJoyZS4ARSPmwS81uirxgzEnJY
         5ewZ9lut5uoE/zQsvM3ALrInF/joOMvhHXymMgz2o2jLnmAMXjRCF6zzYF4+uvMNKgQW
         rryYamXa4qgpXcsvqcD7i3BjTWI6yTP0zr/gooKH4jqyJkws/XOHHTSFp4M42dCrAEGl
         tepr1gZCvbB/wnmTl2s9axWNqRuiKxHAVOnGj6Y0su35BzRLts5KCAnVUmiHB/stlrMI
         8tDwr2N0QRngZltAYHWsfvENdxPkncxZVA6J11jI1orn51by78SB4lKsr36/9Micj0rZ
         4Xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
        fh=FytoeCVcXNOgOa5mE2WQqDER4ByfIjXxoR8U7ns70VQ=;
        b=TlcyreUvNpjbuS8WuRWm5N6yOOjv3HmUUnbq8SH2VvvqQaT+G6dxSdb47qp11xqXux
         Oqofr5W6eOWUE+f6VRrivWDyeUOO3AITRnCYKvR5uankyexNuPk+LdiZG3OfPtCh0pZn
         98MEz4dBNEvm8vqLM7Hs8WPzkEgDKvP3B6FDRwTyiMeNjt2F3ksOicPzVa4rMTuwIugw
         NIA6jRz+IOq8NboTCpc5AEylYeDNFzkOxLybWLjhOHipj3oFUZZQUC24TRxjVVgf3Osg
         gBlZ3LUI7GWrp8RgNgcqTDzCwE8z8W/Ns9ry+6nAqKJiAO4KQ46xaD64HQfJDCdS1REg
         KZRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621179; x=1775225979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
        b=tPcwL7XD1uJrgKVAF4WG6zATiThrPjjcfjqpoXmPMAv3T7I/c5e3wtR519/7UgsSWb
         CxShTzJS/ezDwsZIuPnr2s5LX0NeddARpRh9TgHP611NyuflkzMkhmUalhy6xBxPQ/3u
         Y8o4buuyOVuijmhv1SGL8oi0O4S8vDvVdvV58tYJRg5NRIEa3WC32llZsvIiIMK5qSe8
         uGOe5M2OTisOrO8UT7QAuA5WgTsJJpUGCMjyhEbkQDXmgoqDQ+rv3MDfhmKgiwxRE8pJ
         HuGSB41bAvDvLv9DE3WgqIEiav5D5aXtSxahcJmISVJwdYYrjgD1gp6v8HC3xfxnrkRz
         zq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621179; x=1775225979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0yl5gBevi6k9h6Sa7NsSquy5hajoaTetiMQVol8jXc=;
        b=rQNcEfaes+ylgBm+/Gnpc7fTLLbfe1GcN3sGb9kkMtz2bJWhhlMak4wWcx3VKcb7/1
         1pk66ojJlo0UGoCwEYmJSejgVDRrI7cL0tRon+snKSllctpQ7cFQoLnpbg9YA43AE3se
         ZMkXi2Kl4BDDxV3Mrm6wRBpo5p0IC8l5fT1KuXPSZulY0T1HUqs1EppHUXKzdIV+1R6f
         M9Cfl27Ixw5nkr4fBTBMkMyQ6Ub/c8xxd4z6yworUbzqIm+N2sWPayDrp/R8zUM8YhZW
         8G8yWrzlhZKvPnnEqlYGtSH27GQIAldjiF4c2GpwKEvlxDmYR51NBOhlUVgb5Df7E9a2
         TLzA==
X-Forwarded-Encrypted: i=1; AJvYcCXu6yKpmm+XnahOTg9WIm5hcOB5YTjpWPYkXvJ+i6YWBvOxP5U3yDLoSyXvMAresFkiQ6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHw9mQK0O/i6HQ+Wxvr3y4wV6aKFk0vKTo0ZS3rrdXq/TlYM2B
	deVtV1JxDs5NIE2yCTnMDE3+/R5+OUVCWnfJN2FXqMFbmNLSsyETFqEw19MVWlBUDt0FkMLHC5w
	0b8PaoLikct21AdnEoq8KPeXSivjEwPbCOCAWBJd3CQ==
X-Gm-Gg: ATEYQzzqcvWG6g5rhg+BN8v+HnXwgbSl079EWb/tMe53aeB8tkQRKbT0csYL3qWS/5d
	SmfsfYZhzYpR6dw9dWA817a024S+XbM/bo1rLDPXfUGaL3254NrKtD+Vz8c/urYvJeHDOBLbMrJ
	Z37oJURBwVvdEnh9boSaexNSvE7oofQeIhVvfmAqLjl0rQ19H3lvBxREMwHJ/+e8dHlPbEWKkUm
	9Pi84LmXhBdlorCk+/kV9RwfH4LUyqbRhzaycBtkFKJ59pi3Etey/hbVo7gIKLetAeEvDdXLbfb
	Ah5dyvVS1eKjwLoJgaUxaZzbzHAC4hRdwd4wmw2GwNojaXt9kqIATIAb/Hh9/CGS2p0=
X-Received: by 2002:a05:690e:4801:b0:64c:ec53:4dc2 with SMTP id
 956f58d0204a3-64ff71f7ddfmr2032330d50.18.1774621178891; Fri, 27 Mar 2026
 07:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-13-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-13-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:19:27 +0000
X-Gm-Features: AQROBzD-AGG4_FuWYl8Jf7kw8AaMpvSWoCSg9QpVLJsnXjr7qEvYKJTIbdMJZ1U
Message-ID: <CAFEAcA-+d1pcSRBnLV75AFUFkadfxXsN5156bh8hjW_Re8vD9g@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] util: Remove unused dirent.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This one is OK to drop, because the rewrite of path.c in
> commit f3a8bdc1d5b26 removed the uses of the dirent.h functions.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
