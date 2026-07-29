Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEA468C18
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352467; cv=none; b=WsSfouxptZLSxpCml5oZcQqVCSGzfT5OjEynHY/fqDPAfSJjFAqSY1syCQrQtWERGj5+4Q+v/8volhGsLbAmjGnvWZXbh8iie52bXsk8JbKQLwYTANaWGNjHPgxyFtdT7n4FQ1wcysVv78juZ/NNX3QtUNo6Cxxm4TykOnHR/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352467; c=relaxed/simple;
	bh=p+KQBr3YBqi1Te9/qMRupI2bpcRUQjWYqgBXzXRGFJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hr6cReaT3Gjdv0sqxLuAX57ovMSZMYxOvtMPl5tg08seMZJTuchsKCVsS/hD2lIu7FpbzuebOgDemN7qyGSNJ+coMKKhBEhf7Vzw6iLU+p6PtTujrJaML8cMFxfQNOVp7ietlPTL5pfMQrqeUDdws1oVpzAZgUbJz2yMilrnYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6g7+k1n; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6g7+k1n"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1491933a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785352465; x=1785957265; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+h3h28T4F1i6amtJLbBYljCpqUwi0VZ2BDIbc8sgVg=;
        b=i6g7+k1np5PqMVVBvYNTU1mlUWjAyX/rdSpg6Ju6vwQ2ndPl0FXS6hJnP+oLd+lBLD
         33TiMMKSjo303RG0IbIuyAYqW12goE0NEV7EyBYktODfHawWFxPYo319632cLnie/6qq
         zChajurLslk3FkHdPFUSQVKnb1i9NAFUJA+2TaQ9TV/ksIrMJxLgM6Y6iQ0Qv5OaMJTG
         bMaU7vPhQdnYLWbjS7NL//0KqwUx9NvVn+oIsJdciJ9TIQ+oSDqbasaktd/v+gaRkiRB
         7BFWsbGWPPujJf141Z8HOD6RDk3jeNDOuhCdMqsZC96GeMADfrL/Pg+QOajrzdMQEYy8
         J6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352465; x=1785957265;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+h3h28T4F1i6amtJLbBYljCpqUwi0VZ2BDIbc8sgVg=;
        b=dc1wQ3tMJr3Dpcqj4wWr6VsxN1uhzxbLo1ROmQktAyt3jHa6LA4M0/HktnpnKCd1MA
         ALqOlHqYmhwTeuHKTFeQrbK1c+d8GnNvq1xJ4alnmOf8AYGFdSlL73nfoCUVelxlXGUf
         yDcQvudQVCWa3LDQIWw4Etx0zPk7Nhy3YBvEBWZODKdFKtK1HvbcnVlS9vhLP6/RVUJU
         UdM/dxFxXBVgRPwWGoyKNeyqmxPjggNp/NqPE+JQ0/tkq774pukKZJ2dn/8iY82+AMh3
         VGPbsmwfObveg9f3Qnq9nvr5rK2VRQ0ukKjY4wGLj6l6ID+SH9sLHLx/Qp+CO80M4cOE
         zDVw==
X-Gm-Message-State: AOJu0Yz2vSuk0NwObExKgGsAdr4fsNSyPcVp35bjyQcA0gSnXWYGtXhl
	4YMj83xTc7WJUjmdH6KIQyd+5rKmMNupTVScitnx9E4QXGkeWRdSGFKUM+m5wgjqbqAOEpf+otH
	Otov4DA==
X-Received: from pgae5.prod.google.com ([2002:a63:3705:0:b0:cb2:54cf:afe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3204:b0:3c6:5673:2bd1
 with SMTP id adf61e73a8af0-3c8ba5da101mr8929380637.42.1785352465072; Wed, 29
 Jul 2026 12:14:25 -0700 (PDT)
Date: Wed, 29 Jul 2026 12:14:24 -0700
In-Reply-To: <20260331194202.1722082-7-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-7-vipinsh@google.com>
Message-ID: <ampREGtEqKh8_-Ua@google.com>
Subject: Re: [PATCH v4 6/9] KVM: selftests: Add various print flags to KVM
 selftest runner
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, anup@brainfault.org, atish.patra@linux.dev, 
	zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Vipin Sharma wrote:
> @@ -27,10 +34,14 @@ class TestRunner:
>          return test
>  
>      def _log_result(self, test_result):
> -        logger.info("*** stdout ***\n" + test_result.stdout)
> -        logger.info("*** stderr ***\n" + test_result.stderr)
> -        logger.log(test_result.status,
> -                   f"[{test_result.status.name}] {test_result.test_path}")
> +        print_level = self.print_stds.get(test_result.status, "full")
> +
> +        if (print_level == "full" or print_level == "stdout"):
> +            logger.info("*** stdout ***\n" + test_result.stdout)

IMO, when the print_level is exactly stdout or stderr, the runner shouldn't spit
out the "*** std{out,err} ***" line, as it's pure noise.  E.g.

        print("\033[2K", end="\r", flush=True)
        if (print_level == "full"):
            logger.info("*** stdout ***\n" + test_result.stdout)
            logger.info("*** stderr ***\n" + test_result.stderr)
        elif (print_level == "stdout"):
            logger.info(test_result.stdout)
        elif (print_level == "stderr"):
            logger.info(test_result.stderr)

> +        if (print_level == "full" or print_level == "stderr"):
> +            logger.info("*** stderr ***\n" + test_result.stderr)
> +        if (print_level != "off"):
> +            logger.log(test_result.status, f"[{test_result.status.name}] {test_result.test_path}")
>  
>      def start(self):
>          ret = 0
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
