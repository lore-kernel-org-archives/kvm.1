Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165421B192
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497872; cv=none; b=rwygDM/HXXF4GKUUlU9KsZQuaamK3VzW3DNeWleIvdTKhmIMcxlvU44ZEoTm6xdT1qGCuRctQMCDp8St/U6Bhj6OF+v2ESJMzHzxqYwuJ/61MeXG+pn1+hVuaOq519Frhwp93PaOuGrQcXS0JPAjy8vXfxhNQzBziANeKfgSmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497872; c=relaxed/simple;
	bh=WUs7gb4X0dktqJ2K20s3J+bAtuWEGcrYha06520AAes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RztMuR/7mr8ZCBCS2YZ7DhTomtpINB74V/EPAU3zQm1/n8M1qz/Kf+W7Kls9ZgSJHaW0mTPej6tkRH8u/HDYeY8rfXzslk/O2Fz6aQmYS0D54siHxfxx6/YL+W7CQHtNqExj5WjMHJH5MWmNJey5876Hdns4NQ+gg8BYPv65i/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s13xRv3h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s13xRv3h"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso65971765e9.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779497869; x=1780102669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUs7gb4X0dktqJ2K20s3J+bAtuWEGcrYha06520AAes=;
        b=s13xRv3hvjF6QG9UP1jtRmiVJXvIcorpZJcvHquSRZKVDy1OrbKKbLXysAuiH1Mu3y
         Xx/YaKiY2gz0XbACfIW7wRGh0TEWxmV9KzhKdchhhOoYuhrCQnds+IjtqnpTj99aO3pw
         xoFiX0nU9X17NvJ5nzAEbK7FECy2ZFD5qleFQ/jp6gXD39aIu3BjPSzMZPvxeHLcjtof
         A7BOOybIPt40UO7BuvbIVrcEsQYKYqo/LyLekeung1IF/WOp6g3ajKqGip1Q4llLpkcE
         oqUa5tKz/wEevwJHQR6U5jkmiJHIoIa9QjbNnIileQBuqQIiMvaVh7U+pzWgTDgM695v
         cOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779497869; x=1780102669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUs7gb4X0dktqJ2K20s3J+bAtuWEGcrYha06520AAes=;
        b=hGg6h+GEaQZEXQADq25DEs0XHOQp4yHYEWloJtT4fKIxIs3timboN6KDMHI9y8SMhZ
         G9GTkwUPcshVBPaUZ/RUTSWFsB2b9j84iR+niDn3eSKd2wBqUA2mm9taimzy4iT/ex/6
         4whEBKg1+/DKRJQp30wzwPyeFzlfgoXgiRWCQkYD2eHedrdFhJWFymXdVH+BuxGlgPDH
         UD2xHmb7pnvVWsy8UoPtCBeuRPs58bpQSRqmE4CwAQ1Rxmc9gyxmiE7seyex/tGMXZjh
         Sc9eNkilSoPih18VEGg2h8yg3lXWJOp17EZ6ZncN2jcZQuVdz5qEBe0yktdxCI+W6A/w
         egQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eldgmvZexqgMHKTdCKIFBsclk8hnoSuat5hWEiv7MhvkaK+smJDdzT3Fd2IxRha1xRjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHByD7hA2HrjfrhwIcT9c98GIXf7vn04BEHeaRGzpmQL1ug6H3
	nMYlF+RZJYwv9AKGyXhutKO6SbwfX0+lOQY4T5sDaOQYrHXitaTV0VS3
X-Gm-Gg: Acq92OH7TybyNc2rFChjQ3NnRNB6go3JpETBN06310PCx0lyJLEEkIbUQwVaLPMD9t/
	9/TfmkCeXd0N/zx2qO2qgDTJFKc0ERSgAyeBiqlJ25g5dRXgfTg/ywpmxSEQGMoDs21esNAhM4P
	0WWn4JlcM0fWyP3c6JXOViGXd4psgbbQaFkM3dMR0yzpJJBceyBcPPjR0/IxdhUZNGJ5+yscrLU
	/XOHjaFcYZHJueYrgIyOUrfwmtyvxtpn7Z31Wa95fgV+4UR9pK+0uE6eH33xQaFPwUQYQ64lenH
	Ypc9ghVNHDoI5zAc1f2hdv/T40Hj7Hk7wJwGEktVDbo0qpzUOIO/wszMHFEY19HusefPno30sWz
	4CUIHg8ZzSwKfh16PyCX8FRo3Xbt7aniPIFpxj5i2rh1jHOEIywh8GIYlnyn8bR5HId72fSs6A0
	Bgmeu6wfQJji6XrZX+DVoMpm1wOE7zoYUWVWuUAYJTuaN2iBeYClM/R1ZX5Wwr0HoNWPtUy3W1r
	kVNJQ==
X-Received: by 2002:a05:600c:1550:b0:490:48a0:b87a with SMTP id 5b1f17b1804b1-49048a0b90dmr56445365e9.9.1779497869303;
        Fri, 22 May 2026 17:57:49 -0700 (PDT)
Received: from ?IPV6:2407:d000:508:aa0:95fa:ebc8:3e52:4986? ([2407:d000:508:aa0:95fa:ebc8:3e52:4986])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452580dfsm38704615e9.1.2026.05.22.17.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 17:57:48 -0700 (PDT)
Message-ID: <ac5d0889-0cc2-478e-9e23-bffdc39983bc@gmail.com>
Date: Sat, 23 May 2026 05:57:45 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: elf: Include <endian.h> instead of
 <bits/endian.h>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Brigham Campbell <me@brighamcampbell.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409164020.1575176-4-hisamshar@gmail.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <20260409164020.1575176-4-hisamshar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping. Could I get some feedback on this patch?

Thanks,
Hisam
