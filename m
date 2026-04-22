Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71143C13FD
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849207; cv=none; b=RsZl5Y8+uQtStOXigzyC/smYvo6qozN7diobph2mK+Tg5WZ86vDd0CvSxG2bUbvRzjRFrrtGGBaHpvy2CIYhObJbJ5zipu//JclLlowCux1oGVnmLyNb3Jooitwj7C2lvKTyNIAjbdmE1VB6TDQQ+Bu3907/xfp3Wjzjp8BK70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849207; c=relaxed/simple;
	bh=lnDH+L5FeyefzEiOwoi//zMzH528ayKYykWRM2wp6vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXKHC/rgsGZXdJdE23Um5FcB+OFD/O7BfbE7cvUU2VDMl5lbG9PMyWRpxnqLwK0Y/RchYi2wlVoj5V6eLVCmziSNzXXDdSTKeirs0jjimFS7Bdy6c8Gmt/+zEum+Lu6UR7xm3SRxiLle292JIy8RjUJApq9nWYc12EVyeKwxOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPzbSsZ1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPzbSsZ1"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b941762394aso708437966b.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776849204; x=1777454004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKsuHuOjVnQIcIxkx06GjcZGC/dgb1PFZKky9ByNtmc=;
        b=jPzbSsZ1GuZlxJ8NV3SvUI6vf3xLYDDj4+haUtF8zUg5blgFOCFfe9SvorHViNWXM7
         oaocCs11Retpkh+ON0Z8qyeCboBWIBKGTpv22Xceqf0R3WqGxLBk6+Z1SXU3vJw+/J37
         ldxjS1BfTsUb/krcK6CDgqzfjtOoom0hJ9Lzblxs11TX2q7/NYYmndx4DHcek3sM7tJ0
         Hu0F+9GkikWaGznKgA2sJQet5Br5zVSg9vAurjoxzs+2s4WKOsrd0IEN7byuRUxO538b
         5/kKkLcp1DVuRW001D9REi9z9eEGnQSroYhy94ZqgE9pMkU/Qw/GZvTvbet4aWp4gPio
         gjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776849204; x=1777454004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKsuHuOjVnQIcIxkx06GjcZGC/dgb1PFZKky9ByNtmc=;
        b=X9IiKQoggTuX/SER3qzKxXHnC4FNkEo99FU8hmBzHDeSAIhPVq4We5TVOHUBc+J1iA
         THZsaJmmeEnMn1rfFz3FqDqIoWM65nTjP0/VMg7ktxPGIhZZQuAWDO8qVPO6QgnpkBzr
         TsXVVTNmAQ7vAXUGwS3OVDS6SJAdA7GLTrkvWIrf5ycY5QEgSZFx7PpvKPJZ8UarYh0w
         98HHAlOqwaagWxeMnUXzFn34cEwVtaOSG95AkXRItDz2MYPs1foMka/SqJgeLItb9ZvA
         DeA4H75mklc+7xNWwimQHDyNu/YMSofrWyJU/XZ/WJ8TInQjPlzXX7ZpdRLhJvBFEnfI
         CYGg==
X-Gm-Message-State: AOJu0Yx1Y0s4hKkEe7CUPqyqJVXq1Bic+3rgMaCfjlY5EWRBQcAFbBkl
	L+3QRLZtUJrCeuJP6bkjUA6JEUaswToyq+H0+toVU1RISRhGHdIuXuDZ
X-Gm-Gg: AeBDievEpfbnwJYaNMVeUHxVDzdpvSu9AffAWQ2+CSzdkJnIJrXv7FMpefOilS+8Im6
	DloHCDQBZN9dTGjqe7yk9+B4765HwNxS8l+TChQPkpVQ3enit9fpY74gqt4k4fJbTBAs7Lj6L5p
	WXmIYJqdkgCjGldF0MavbScBT+1pNuuaMRBWpuNP0c1cZ17Ywonw+gwtpHtCW8LGTurXWuqdVNX
	Dyo5tYxSHPsJDniwHrSQNDC4Fe2CAWNn53rDR0Vi9bv71yaq/nKZCNvlstxZVOi2FBjXsbEQxJQ
	5ehaiO1TTET8FOwttif3kNR4h3NT+jatA5i4n8i6lcM/AooUEWy98T0AgzAJB+i6yklkmnr4bu+
	E5p2gtgHT+Dhm8FvUNi/S8oOnciNzmm1Lsd1vHVdgqqSyx4mryehgCSx5qUQvnBNFaViyZwASXO
	OQQEm9/lNBUCP9KybGSK7oJ7PIk7i+QVAf1uZ3AUSgLm3djN+wmnUVYReQ7Gg7BhfYMG5KsLJvG
	fvnWe/oQPwc
X-Received: by 2002:a17:907:3d4f:b0:ba8:d9b6:4993 with SMTP id a640c23a62f3a-ba8d9b64b32mr476670466b.8.1776849203836;
        Wed, 22 Apr 2026 02:13:23 -0700 (PDT)
Received: from localhost (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba538429115sm464634766b.15.2026.04.22.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:13:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:13:33 +0200
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, vkuznets@redhat.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: hyperv_tlb_flush: replace NOP loop with
 udelay()
Message-ID: <aeiM82FpO-CcqBlI@arch-piotr>
References: <20260421172953.191345-1-piotr.zarycki@gmail.com>
 <aefZrtpivxh0eK_0@stanley.mountain>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefZrtpivxh0eK_0@stanley.mountain>

On Tue, Apr 21, 2026 at 11:10:22PM +0300, Dan Carpenter wrote:
> 
> How did you test this?
> 


  I built the test using:

    make -C tools/testing/selftests/kvm ARCH=x86_64 x86/hyperv_tlb_flush

  And ran it 100 times to verify it passes consistently

    results: 100/100 passed, 0 failed
    average time: 466ms

  For comparison, the original NOP loop averaged ~537ms on the same machine.
