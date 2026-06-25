Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9EC1A9F96
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346774; cv=pass; b=rJY2vtXi9n6YCux0oRJ6HVt+/yP9LIiqfChhXqExe6ImX4fxOBuWAMCewBxxOWrf20zrm4Uzd97hBuVA3k0me1gj/YwV1+YXPI6sLCtr92XC6AXBAzZBHc5hkmas26AyuaXGbdNYt7dDHK/94qgPdxn0b42yY+ZbGKQmYdSX2W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346774; c=relaxed/simple;
	bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L32lPJCOecamtofPQmL38aOzoXaQhTkhewV31vKahL1QK2nYhv44IrfMDmMlzmYGQtAwilRVZqB3X4xKJ3kfk8dtCFQjsZGgVmdIPC8pcLcLEmkrlwZpdEO3oKbbnLcH5bSp1NW/4HJ4kHl7dFVzLtP2vj08ap+2qwPsVU9xbMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6O4rAJ7; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6O4rAJ7"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1397e093f90so4604824c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782346772; cv=none;
        d=google.com; s=arc-20260327;
        b=NofE1jMb5WI4yFFQ8LbmJetQRWUVMiYKKKF12WUol6R1M3Sby9MAVhrjKsvz3NR8xX
         qKWpAgwOj2uwy/FZGoWb+goRljlN3av6vg2pkYo/TvLYYvwQiQ5FYzpIQ8blqUoneWpf
         F8Vs/3tT2FAAPwBmU0YK+0MDnISCl272zlpqRSJ/sBUobvjNBXjK9hOjvQU23Q6v3+Mm
         8YLq8FKs+mbmilcfklKBwe3EpC5VDAkI/5/G33aT7B2M72EuBTtoN3vz21MLrzHaqr5T
         /y61V2h2f0tttZDHANdpvhJqxAuFQxUc/hZvk2pXCfDykG/QhNnJc22bklamW4uyuz/+
         +3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        fh=X3h6gcFgwYIvbK9bioSrJ/BZQ9NPGbuBpo/nI75OJas=;
        b=UfjfuIMqyvpYtuaj5M7jRzHJyjpjwWwk2AdEi2HnVyTxajNWpkDUbcMDOI/brThkI7
         duLwWWV6jiKjPBGH1XgC+giM3RQjjPYdQiskdCp0l2G1VMOH35bNIajxk6DrtqYBoim+
         SHhQAusS3gQUB+EX7fH4iMVEaB9oy3hL6riOFI/APook0BjhC1vBKnadCr2Ma7rvCR9E
         IxSg5ZH3A8E0faQtbr9JTCveDRBPKXQz2MDEnsEfKS5xLcmtf/v6GUWFKhi2jWQGTzpO
         x6ZuNGwPAgFNKu8guyC5711/O8qJIOD0OOUAoGB5bZkTLZYpEzJGpGh5p0d0l/kaXgyW
         YtYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782346772; x=1782951572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        b=l6O4rAJ7BuSElLvSVCjIBLBDcAro2phzO2UoQrwN6+H320mWttnof0i0/lcdgnC9VF
         c9y5WMcG61fE+olfR6gSw8h/vck5HyRGv9OPpvaKvk4dYSiidvvra5Rw9W4ei3WZz5cG
         UDcca5AyuQDRs00QKgdFarXvgscmMWiwFpV2z3nzvCLhch/PKdQuVbStjrT36He7sJ9P
         GhEfxTfvYFKtGxEsKC5xmX7Uv8xQVPMpOur4cPG36WuKyLxOA+L0ckKRLWa8UjYesS6B
         aVZHb21d4C76/LlYbQQRhBVZFjX4vQ965Jjr84Kc0tAN2qbTazomJ5RHU9u9L8RNh6sT
         pxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346772; x=1782951572;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        b=BMpjJZIotFdqMVcBt6WR6AdPCk04bBaOtmiK+bAwrkCi7DVYMDzhjykLqDBIRePcD5
         ONMHsAADTEdcl96BrOa3EP6HSnzZ15h8GE2keadioxMKxWlRYLfjcWGeFWSJaUCCdh5Q
         g4RyXNPVVYllZYG5KLPaD7w633azg8a5y9gj3/V6ZCC0SVAfg040nT1nKGcIRDXZasaW
         4OjiaZbh54dJQbUYQZIBarVlRGQkRZUEQmSa+B3PvSTBeCLr3bQolXRxfafjUDh4Fuh8
         483CQ/ZqIfVCHLn9SufqmcVZJ41ez9DntObTjOTe1F0XUkA6r7xNKEYdeuksZCmjvlzn
         xDKw==
X-Gm-Message-State: AOJu0YwatR8s34teYtHQ+GeBUMm8ym4w/t1ul5CYNtnqeCMvEJ6wZzBb
	9tqfPZeUSXM2G7qGnbNn+fEwk6+WgUOhEr/AaMxGP6iICzsDryPmLyi1La8AHOEISn/cMJqlaOr
	Lee5UvUzvnYNJRRFPQxWiYUwixwYhTFUS+J9nQk7D
X-Gm-Gg: AfdE7ck6QpwRbHW3dUQj3BtPK8KqWVlljuou/tYwTZI5niZyRGD64KvdX5xyvkwdvQ/
	NcMxmJ0rLYpMKohEMaNeHlBXE7BIysHHPsG28ursWGWKzZuAy28ULcMCa/job6QLd4r1CBKLgwT
	LnPWSnUA0gNl88+nZhdnNjudmwwQ/BY5lgi0oWaz/p2it9MQgvkmVVFHVuTXJDq5ISs9a8Hub0G
	DjDFHafMgclZIe6zUnkI7+64To/yIIZCejoGJIXo3AOecJsvqdUnhBwOIMIaJ4vs/HKYx0A0AVj
	AQfcMv8sgcksN8sL8E4Nh75Xp5xdAr3GgyR7jkxtz8Y7zzJ3bZ8nkPOhJ2c=
X-Received: by 2002:a05:7022:fd05:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-139dbab1be2mr235748c88.21.1782346771178; Wed, 24 Jun 2026
 17:19:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a6373206-60b6-454c-9aa9-9d52f9d84de3@amd.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <a6373206-60b6-454c-9aa9-9d52f9d84de3@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 17:19:29 -0700
X-Gm-Features: AVVi8CeipeAcfAxYa6j2yQPCcdB9pyHrAKYmhFznoyz3FS_QiklRPL3N5ubFoHk
Message-ID: <CAEvNRgFUru5GEM7g6Z7nuaqQK2iFmW3w2dPYEKPuehkdGvP2yg@mail.gmail.com>
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
To: "Garg, Shivank" <shivankg@amd.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Garg, Shivank" <shivankg@amd.com> writes:

>
> [...snip...]
>
>
> Hi,
>
> Thanks for this series.
>
> [...snip...]
>
>
> Tested-by: Shivank Garg <shivankg@amd.com>

Thanks for testing!

>
> Best regards,
> Shivank
