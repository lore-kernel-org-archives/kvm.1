Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792448116;
	b=LcdRZd/EOhAht8MNOdzzF/RerEBFnPvAzIz2Tve2tViRRXgTqNIus+YU4ayewstyR5lL
	 1NQxoLdCEPLpUnIel9QhF8qzExUXP4+DCG4C4Xno/AGl/EVfbMvPBbILoBnx/QIZBAKUx
	 Jy+qftRn0X90KJrjsXJABtpe59Y43HiZ46vYhUfjoJLzZIyqu7Zq1O0ipmfBHvaahWzz+
	 T9StAKOQq/nST10U/tmcF25Sy4uXQoA3IDFjAqnjg3w/T7a7f+E63xuJwg1mnU0+0E4Y+
	 n6iGzjc1B7jrrEfaYvUwOe84alhrY6TYno6NPE+9TlP/Da3vZ2xqa+GbyPYhohW0XWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=clYr8DwFtltetRKRB0JrX3TEKea5/FeCgDXXcZMil/U=;
	b=KDSUbZ+cRPpUMcG9ppvE/ullROOWbl5Udn0DzRySgrgfynCsQzp5xCDZLWSVfqYCmxVa
	 MVjZOA0NJS24DLQOUI+wpLo5vIMs6Dg39Phnei8f84cc/99aTa6xyCNrF10LpL8NKHyfJ
	 O/2ScPSgGvYrKes4A9vSDcd9vGzNWJfUzmsN6ZzXfczZyUycgJrlrnIqNWnt8luG12QLo
	 yavzcJnjlr3i/eP63gogKpJhcakq4YrOKWG394EQ4AwMixcT6yuOs7vflrXrPZ5PxvRpN
	 oMbzsaJ88wSDYvjIubV7c6fZlslbrjdIcAuHuQJKrk17Iu2fwNzUgzBtnwatSm5Jc3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V+HwppqT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA9606A323
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 22:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0EA9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V+HwppqT
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1968a12.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 15:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792448114; cv=none;
        d=google.com; s=arc-20260327;
        b=nAcmd2HFStZ0AYauQfEjEEBSor3JY9Wr8LCHe/rZyxnZiCHtUmsS/iG2kdySViP2j1
         2Y2RLx3klFV7O3esJIjJnBI5oAUtGcjTXzFDEX1SDbI+b+ILqTPGVhSamHzPcB7pTr7W
         scV8xydz+Gb46WFibUGLVqWlRPQvdK+mSIkcZ00u2ApsvljVHtD3J+h3qPCT/NO0nDvJ
         KBvRrJSLx3PEo6/EnonXMX8N8SG6wxvoTbvTOdMBWx8RBLP1RsVVmvyla9IvEVUrgvz0
         MNqj4YduksHv+XYYCptOLUGPFctI3uKek6NnZLpWcZczbo2f4wjoZmCpx8uViM0UsMuy
         PG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clYr8DwFtltetRKRB0JrX3TEKea5/FeCgDXXcZMil/U=;
        fh=7TnGASM4vOaJXFvmci5fSUiq/5F+X9T4CIEgW4grEE4=;
        b=lJnB/P3yoBY+2RzfadJ9ILnrHfr/1V0EdHvz3TH4OP8kJuqWTUBhhZBzs6xBGdWkhV
         Nj+QqfyCS46bg1VPGQRrWUYgisVvL6qA0/gFzvuykp6hPbRVCcUneZxwjVVzrUiQB/wi
         PVQuMhfSrIevQzS+6eihdcCHzuqK9Aozobzx9XSs5CeHFFtw1QZ9vYlTV312+YJ0bgaG
         NRWtji38IeOnXTF4LHQhN2CpQFEdcZeg2t0gt7eaNdvm2g9mendH6SmI3HS1m/L3nFXo
         TBfS+k/S6xYXs/cnNPeNmKsGEE4sviKUBir8aQQ0BUrLvj50VEH5vLcYyMAJ9HbK5eM9
         GwUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792448114; x=1793052914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clYr8DwFtltetRKRB0JrX3TEKea5/FeCgDXXcZMil/U=;
        b=V+HwppqTCxSneTNSG276VOQnER1q6/8yvVQdinXUbza3Lb69jkj7hPV4sk2OuXRNPs
         oD1Tp5/+P0XaUt+ZJSYJGo+Aa7afKEsIsyXYyZiMiQWvXQ/ldZmCw95zVYuEaqMIf1eQ
         G1e5JQoTywENOjrymvT6iPbHHVDEx1+XFWJvc2szDL/HToAyslioCTfvvjz7pAtxa3X9
         KA8etRAtfxoQXz5n6UYJivAf+N45zhrjegnTov7VYQTMNVL6/MU4fRrUKaxSw2RxK0R+
         4SgUJ4AgJLSGPPgps8E8HiAdkOqOvH2GHkuZYbyDIH/G/ybcEpbvThys5HbV8V+aSKxO
         TyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448114; x=1793052914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clYr8DwFtltetRKRB0JrX3TEKea5/FeCgDXXcZMil/U=;
        b=z47TOrHrp81pU+wq2px2IYpIxJUZBGJJk6CeIAD/DQQlh8EtqpmFYXX5iV/pXWYR9i
         Tb465FelSzkIV22BsefUv1jmZ+/J4Q1O+Hub0Mb2Y4kQWS69kmg/+ATPomtpb7Lo73Ex
         /G0fLzRg35zqqZQv59/F8mcWXU/dYtV8IjS0eck8LTPurImSqRz3qwS4iMZyvF0ue9tq
         udQO6NCLFEMvqfF8fyc4P0mvZkzSIU3a2QJ958YUetW3cQY2AvlPfI2c4NFh6agxlpXm
         6zLcJ+rNnMt9mRMLzLUILTiBbXvVTdfC4H7l2wt19pyUdU9CBjmTUBmgiwjGt7kBBN+d
         fG9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxzERFwiXwFLjtgbd2NH6dKK7Ijs1JYeHUaOWY6/Kq4jD2lufQWAlUrCQRU74CF/jh6rOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyiGsTXynlDlXYulHap9kWJ8Y9RFKhENHtGVX33VnVDle81GAE
	NGCAUcZwRAhj9EXeJ82vkO9kuW3bQYcIBhVFpQACuNkldDZki76sYIKsPJ26tnJIgoyG5ekgvlb
	ZxgdRXCVWUnKYmNzNbu4hfodV/iV2xUvZv0ZLtgb2
X-Gm-Gg: AYBFou2UAD6+e3IntxaJTnXeNcFs/gAG2GWRG7EblMBDGMJEscMK3QRGp4t3nDumAbK
	agRYbN1dre4+mM8ye4hmaDiNt1D+m+WIjzBpUb4kWLCcYSm/1HJL1hfqebqvEeD8tJ6O37heDKf
	Hsx1k97miREOp6FWHLhmkr4T4NYw2PGsJ61tBGPlW0WfBv+RtdtNCurjkqvNvHNBGpQjBKq1A2k
	kxkfELTgMH3vJ323I4jUuUZDpcAvT+EdIfDjNfxZBfm6Dxb6dXFFNa4vq+xP8hQ8fSfMgMUW7i7
	8HKXwR4QmN8aoM9IRpt86snjBaBI7xtlLKHPQTLuZr6DYM1M/qMu/WY=
X-Received: by 2002:a05:6402:a203:10b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b3ae92499dmr49340a12.15.1792448113735; Mon, 19 Oct 2026
 15:15:13 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-3-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-3-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 19 Oct 2026 15:15:00 -0700
X-Gm-Features: AclHuK9t_rw2VG_gyVpkbgI061kvSWzqm1hothnA18Hoa4xC9qtfjfKrCi8wcYM
Message-ID: <CALMp9eRJcoGe0PUUvC_S=i8vMbB0xw=LhCvwAYWwA1eqW-kEWA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] KVM: SVM: Add the LbrExtV2 CPUID feature bit
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> From: Sandipan Das <sandipan.das@amd.com>
>
> Define the LbrExtV2 KVM feature (CPUID 0x80000022.EAX[1]), so that KVM
> can track it in guest CPUID and advertise it to userspace.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
