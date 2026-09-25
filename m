Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E184F30C9;
	Fri, 25 Sep 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369470; cv=none; b=IyLXolXlMv6hraYrOhkt5w+B0MiNKQGZ+hyZUENM29UiUDxpwhJ+nZONNVGYxHogjSYUNzN9a2geOHBTP6Qejfx/YVrsa41ewlOPXh4/KqSVwceF9RCmiCurb7uad6BNH9dF9Udj/r9T7FALSchNQGYsjEvlrqZ9ABLSSSpR5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369470; c=relaxed/simple;
	bh=uqF4ekjBgk6CXbISxWTospA6SOWC8kyYWzay9Q0HLEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB74PyLDJZOF3m/4wFRQEYD1sKeo5iU5aKA1zJe6/pOdNe8vkVKbxY7c1PuHWGu1pU60x+aU5kn+nkhVHB3Gi1a1nSdbq3BuYWDjYbXCUrE9lZe9bznU9F130z6hRxS0y7UXOCyINScSQGsrAJPFIXbyxVjhY0rz+kihyT1pRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=f+NWjcD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEPgLqsU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="f+NWjcD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEPgLqsU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 632631400134;
	Fri, 25 Sep 2026 16:51:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 16:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790369467;
	 x=1790455867; bh=q8AdQN9aiCBcFO1/BGWaQ8uF2/aTbqyedNT7Mebievw=; b=
	f+NWjcD00jeIaUfWnHNuYus8srJNwFUzmfkFb+1uDLJgrpssDhnn8k1JdcwCFie7
	868QeYLpXYTUF7DdijslU0YWrjDdOhANn3eP8tKxg6AHYoyEr0LgOvvtOYYEYlLB
	yVCMGO0OePB7gJXI1C30Cr8D6Ms1TNisgtJATkvLHAOPua68RQUQyd8+7nzyaxcT
	uMzpMZd04jq89uEL6mJ+xqVNl1A4KdiZ+AuK6EAx+/GoJA/lFXtYUZQUOnAva9vg
	xkDRuFaN8mGKjxx4Y8NS+m4vDQgJ/q7Pi4qYcm61SWX+sPsHJADy7nDT2R9xkBmg
	CrvfJm9YSUBvVNYPxg7o6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790369467; x=
	1790455867; bh=q8AdQN9aiCBcFO1/BGWaQ8uF2/aTbqyedNT7Mebievw=; b=P
	EPgLqsU3J/4zHHJ03+HCNFkpCn2T2OjkM70Iuv2G1EcgK1McCrM7Sy/il69nvSn7
	TQVLpZ+nTdpZ4Z8snKwFEcqZhy8LUBQo54stonuu5EUpvtfThLio2/f+drZS2Ir0
	J0sdCC3uHZVCqPV8xm287PzwFMTAx9xka24ZwmGU16kPlNPBIX/4VM0uSi59ATXa
	rwjrsnk73ZxE92mn43bKM6nxgK6/wZSACQxM4u911RuLr3DiRXaQ15Ag/vcP6KLh
	9Z03SODDQ3urDxtK8/6x/pCfO365aVDFXkPVx3ymUQXm1lyEobaQHtxkyNk8fUMq
	C+ojG01Vs8N8XHFtVwg1w==
X-ME-Sender: <xms:u962ajU5r7aZfKQl4lfQ-fkcW6x_c12io6czcZYIao83pQa62rdZyg>
    <xme:u962anfMwd8EKRUuKNgU6WmSCZS_r10Mq9gHu3sxR0lR65CDmAleYgfLchgmn5cNw
    ektSb-OtGbnmb-AjcPfaB-BlkNTpbFzkySj5lKWs2pngBmur3XsyEM>
X-ME-Received: <xmr:u962asYTtuKXJp8nhiTpKehhrtrpIqsoR9wqvxSsuxxGVbCxpBJ3FYEVys12tg>
X-ME-Proxy-Cause: dmFkZTGUv3GzFzpRfg1DCRzsLol8iVAZh3gBSwvl1Vd5DWgX8bhd2+rWhZZqzejJ5ernV9
    Ft3BMLsr+GnD6P/f7DKMgX2AquMCglqvdKbgWRb1rEDngxuZQaEzoEP6clizQHyNRdHqBu
    baTZzc8Ty+UWYvCQVWJqCVjEkr7JS5K8gCOFfSTUzJyL5s5Sj4pPqTB0o/xyLs9XCOAite
    WQL79Ttmv0BpKXwppxTbf5bfsnJ3ApZhBkROgZ2yAF8Y1jg2R+UnEZK7itVNm1OKzF2VMv
    L1wDsyqmuHPLZQdyIa4xi/xKIQH3Zwk1F99FI4+/BQjmrNik/dMcekpUCB0oo/ObiAtmX2
    dYkvaauEG81qDLAhwymHYmuCNIlDPO16gZkxgX1gxP3/JBdUvfRI+1wRIC9Ku74atwAlcK
    eH9ah11hNzxoBstnwXBTK2Uzxm6V4Komwei2XA5JnFWBpdbNNDWLE23nXZntBgm+bhe+nE
    jvGY59qAOgdzkBs4knFQHBhqLPOfPZzyOnbVRRqlLW90T3wLjPymcgKVMS0b1MAAG7+0cw
    mNuZQjVUs+H11nEFBo4K9D7Co9TV49K5ai5HUozaOcPfCUOtPvtbtGslgkKp6GKeIuM0A1
    qa3nQEAyM9jY+RTG3+rzbaXzeZVdTylXDrZ8zK+mQgaoIQOg7rdICqxj36HA
X-ME-Proxy: <xmx:u962ajO6A8lb2ZVJdo37cDUuOwu2SvUn5vtG20CdEbcErc4NXDf3Dg>
    <xmx:u962aiVTNZkbZ-tqIU0EzdPZUtaIjjSsHPFJjVNAwBetnfHp0DvY6g>
    <xmx:u962agLiMROdKQH9Wba327zqOOX-zXojkL5vvGQgWelZ307_iYj4SQ>
    <xmx:u962alqdrVlyLVvXcOK29Li2AJzmsnS-NWhKa25hmU4UcmnztorgUQ>
    <xmx:u962avhf23kTNNlTzkeLO7SVXNpr_pLrhXhuVdop6pdYU1ZHwByHaNsR>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 16:51:06 -0400 (EDT)
Date: Fri, 25 Sep 2026 14:49:07 -0600
From: Alex Williamson <alex@shazbot.org>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, dmatlack@google.com, shuah@kernel.org,
 seanjc@google.com, jrhilke@google.com, rananta@google.com,
 vipinsh@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio: selftests: Include <libgen.h> for basename()
 on non-glibc builds
Message-ID: <20260925144907.15cc0dcb@shazbot.org>
In-Reply-To: <20260824222845.459181-3-hisamshar@gmail.com>
References: <20260824222845.459181-3-hisamshar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 03:28:47 +0500
Hisam Mehboob <hisamshar@gmail.com> wrote:

> sysfs.c calls basename() but does not include its declaration.
> Glibc exposes basename() through <string.h> with _GNU_SOURCE, while
> musl declares it in <libgen.h>.
> 
> With musl, this results in an implicit-function-declaration error and
> subsequent type-mismatch errors at the callers.
> 
> Include <libgen.h> so the declaration is available on both glibc and
> musl. This is safe at both call sites: the arguments are local writable
> char[PATH_MAX] buffers filled by readlink_safe().
> 
> Link: https://lore.kernel.org/kvm/CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com/
> Fixes: a262fc49e0aa ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
> ---
> v2:
>   - Changed subject prefix from "selftests/vfio:" to "vfio: selftests:"
>   - Added David's Reviewed-by tag.
> 
>  tools/testing/selftests/vfio/lib/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
> index 11415448b2e2..daf117a299a6 100644
> --- a/tools/testing/selftests/vfio/lib/sysfs.c
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>

Applied to vfio next for v7.4.  Thanks,

Alex
