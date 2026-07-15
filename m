Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2F18AE3
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074022; cv=pass; b=atICwTuJsfjTYBmEHL/e33YwqVRT3oKEFp+ve+N4fkCTppw6WfP3KjOT7kPj6ivvQar/ApZ30FrwDAJvG+59Zx3pIua+e8gDg2K9ivW87DZxZcgBgMfTbeYbq8mNMuLrnQFfG7pebDr3gabZIBc+zk8h42vaNs3QeiIzmhRucFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074022; c=relaxed/simple;
	bh=YU0lyzGyOUNNiU5haIvFPS1QAnEsD8Z6p2DCYWVvj1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llKnj3zwQ/ui6QXFKVhUCDjcAssvyuyRmwM7XH4O5I88RItGQM3/K19DxeNj+RuVgLi9wu8/BFGefznFhTJGngqKsTAGWg8u0Pyg4SbKjyaAuccyVg9HduS7ySdwgeiP91Ym+185M3Y+msLpbKNeMMbigNsXTTsFMMmAoD0HrmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlrrwGfB; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlrrwGfB"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9aea40d799so713085a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784074020; cv=none;
        d=google.com; s=arc-20260327;
        b=GB29CVavFl52bsUyK6xqlY2pKlBYhEhEA3aamaXqGholoP/DIs20ftpZ9j0J8fz8Rl
         ZXfz/vrzAroKdKiFQM+T5GV72LBexZ5I9YMGfQFg+/sKb7EjVCRWc9ITwXvsWZS5r6yX
         Jv/N78Mu6sF3wBVzUZxEeaBdZaTyo2P8KgVg7mOOjqgU0tCt1AyPsU5cEa4QOG5m7aN6
         wjCBth14weSdXB1++dVvDlqbaoq59IGGhi2Dhvg57j0MPOFo+B+7WO6GL8Jb+DCKBAeM
         2YJQCUgD6qyLTYGJbLQoKmuOzpXqExcYeUgUEpbVOHbdbXcSfNf0bgkaBVrmDgtmnOcX
         cw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=0s2vP5FfW86C14AQBw3ERXXReFpty64yWPMq0+acSrU=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=DBEHVX5zKzF/XSQSxbpyZPK5Yx4/snuU3ev7RpUCaUrHIwV3+hI0AC6mpXfP2JhGvc
         OuMvn8WlXGJuPzRg9WH+zMrUAat5kN07JXPQnfl7l83tsUo9/EwXEiISicF4/1J5hQ6b
         Xd17nUKIL8kD/8v6n3CFWrqNS4rxtyZfbgbGOLoWgVhcH7RQPIIcZVX+ldk16L+lUAsG
         4Ac5V4VDEkNM2/rqzBA3sX/8G0GM/tN0+nio9c+NXW3kFG78VI1GCGI3a+xFthNXWrH6
         TMHOr1TMZoopJGeIQJAOmPStR0jr0g5H8c1uHf/OHmo26w1SaEm/mKj08+DUXhNe8rG0
         9SVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784074020; x=1784678820; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0s2vP5FfW86C14AQBw3ERXXReFpty64yWPMq0+acSrU=;
        b=KlrrwGfBCK15ej2pw0QdvhZRpCeIwsgO/VjEEMAWtwxZH9V1r3ZP6skpM0ouE0o+oe
         t2T4nmBtwxoo1R5Y40c8XN1HCbfrIM62LwcCrjvtkba8KkwwNkabXQGtk7J2VBMtZ8P8
         8PC0CTuTfJvBSujNqDxJ26kQsH3HL/y8brchcvrOejBrIDDnr36yGjZ+JONNO/z6Xz5I
         gE6q9TCqDih4g/EddrnVVzb8tLjuJfNKVNsBo7tY8kHxi3oACKApWFJcpNmE4DNQ3w6A
         4iDZsxViJV4ZxStRHpKenj501JVaXok1HejtnSJogpXxCQa+1XFs9eIpt6U6rumXQU2L
         6zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074020; x=1784678820;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0s2vP5FfW86C14AQBw3ERXXReFpty64yWPMq0+acSrU=;
        b=POrCVBPzSD5JPlJzNjWZLNTBzyX7LrWAXG8zYSpev1kun/Qa0B8tT+8VbljQx8uiqi
         H3o5dtkFtK4jFEqS7ZvLn+/XMI8PZtaUNnJEipZpGC2uLn3Dg8D759zMOnOKD8Xbz24/
         d3zEF4i2aPYRKjfdW3fMNqs0DEY9X0b+Umu2PIkze9IVODP7PW0KeY5WeOF9r3zhsaC+
         yezzX4XTZ90Zh4miX82udMPs/4RF3XSUzORuwC2/Dbfjhez5CKbVPwLHT9edjHnyr+Ep
         51uUoGYFxtCgucWicEjt863QPaSHTe9+0WGYEgYASBs3BH8ghh5bwheFHbIEVgHCfZ4M
         vmbw==
X-Gm-Message-State: AOJu0Yw48HRt0iitBfhHStRuGHKY23HL4vZt8bBk7irZ1mMvLydIhxly
	r3STjF5jk/bl8QS9XckzuUSNCWHEwEQDpFv+uHrv6kINEkoh3I0c7BHejVQxnGfADJGiISsA01u
	+1/7ckVcHQpuHWaqxzBb81aFgVE/2sj9aYwVZ3NfBcTYeTxbKotkJAggj
X-Gm-Gg: AfdE7clXiV1eQeQsONLB2FbZFOAiqzeAlAWd+LLUH/tMIHzXuWW/WtfZBPaJLbaG/nC
	WRxKaIQ4slD7SAhIVfdudTp0HEwtyLANg/RZAqtl1Pc8wLSNeWvK1AXTCQcMfhZZTtOmcfoJayx
	WK5kmZSOeDBcNVfc+mgdeU+QdzWoqQ73cONe/e5dmVUDMYS7LTtC6Unt68Ikl7u5A1tM7AV+FP4
	2AcAy/k+BhDbhZ7/oyKSX+ypGKI50vJCmazQNhJSO560oqPt2a64EoKdT3eVHuMmmGjJpDMxU+9
	vtnPg+vb6Hih68pePcNEx9M3aLa69uWOKESacQ+Ezt8so8nFNviZyRXeEr4=
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id
 adf61e73a8af0-3c110b33403mr17211533637.71.1784074019800; Tue, 14 Jul 2026
 17:06:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 17:06:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 17:06:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-7-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jul 2026 17:06:59 -0700
X-Gm-Features: AUfX_mxQm68yl4Vo3_LIRVbitzTqwBY7WF58Mhm8WJlRgKBSK0sif-PgrebnF2A
Message-ID: <CAEvNRgG1Jm7k1F1H9TK3ACvsbHYBzoNEohvii_N0_da_ForTRw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> +int sev_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +		     kvm_pfn_t nr_pages, int order, bool to_private)
> +{
> +	if (to_private) {
> +		if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SHIFT)))

Omg, maxphyaddr is actually the number of bits in an address and not an
address!

Thanks for explaining on v4.

> +			return -EIO;
> +
> +		return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
> +	}
> +
> +	sev_gmem_make_shared(pfn, nr_pages);
> +	return 0;
> +}
> +
>
> [...snip...]
>

>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
>  {
> -	kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
> +	WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));

This setup means later pKVM would have to define a .gmem_convert but
actually only use it for reclaim, which seems kind of an odd
definition. (We can fix this later.)

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  }
>  #endif
>
> --
> 2.55.0.141.g00534a21ce-goog
