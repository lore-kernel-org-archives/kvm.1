Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792626570;
	b=lOf0rDcM18LsUiLSUZRKs4Oa/fW0zNCdo5KUQXdm/Smwr1Yef91fQWiZ1IxL1yII+vqt
	 zCus58R5d4+tInxSY5qAzMajzf+CkBNbY4h+RgRnc9oY4NQcxb72BpPFvQHMnmvh/kPuJ
	 3OQfmNFG7AQ87lhcy2nToVAlCO/z7wiOBHWuVoBRXGrzrO8tVsjk44PkxQ/ztPKLdAfOw
	 f/L9kDpFPK73W17rXnrGMY/uUGfuydbEjRyk4oAzycSuxrKqa9VS9GEADkBX7guQQNSrN
	 /NzEednzs6ghwrJZTz8bLbDQBzvlZuIFRMryT+JCOb8xfIaQBps3y7ozYvKpR7w9cTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l1CEXyVgQMbFVsk7IoQbzUTVIyGJIWJ7DnssjbN9Dfs=;
	b=N8pMYd/7GgQZLeLqmwm4qj5IBbChu5SPL22pNLyCKqAEt9e77F1Wj6ZLKcetoUYE6rx3
	 PWe2f8VIkj++Swy+jsUhuyTmxEVfLF3sqokWLiiBvHcPELjGN4Wy2Vr7kI5FsM7aa/1eJ
	 x1lZsmwBTfSUFQU8q0RiG2YT5tG2gqeSW+k6LWQRqLuNa91u+PJyXjnkCmglerW/q8zc6
	 oPthplTWZSXc7P9NU4q2/AspwkTqQ35yLIVsj+Ewml0ThCi0VlAm93CV6nWGb1jNvTin3
	 HqheR/57TTg3slKwi0Tti0FiqiaoZHE0Ri3dFgAP9NPd57wuPvLs+NMfgjRpfa0P7cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rc9+7aEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E9606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722E9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rc9+7aEz
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2674a12.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792626569; cv=none;
        d=google.com; s=arc-20260327;
        b=LkQ783F53Kpz/uWwjTE/zvAGVIA1jwWJMYNSsB85yPuDfiLbri2FjjXlIDk+NGRw90
         rmhi4afc21E8jr0gLwhL19mpFqOU84aa+fwKA47vy6qX8fAZLbH8qHdGAz7HNna2Qlxf
         0Vc7DSdmJ60gIE7ENv5hSxXSNyfgeDQ69htC/hZi5sfx03HyxSyOHDal5pgTfpDp5ZRP
         4XNuySksSWTjfvt/PzfsBUYSZ9UFo0PaY+vYSJXJMLR/bRPJPuOahHz6b+CfoEpEtNrY
         0u9lFPtbC2+Ny4+3U2gkUOrZiTDgbKTvGO8Lrb401WHQ6LMXWmL9wraFEJg/h5HHVMwx
         YkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l1CEXyVgQMbFVsk7IoQbzUTVIyGJIWJ7DnssjbN9Dfs=;
        fh=BMNNuehLp4ozKHhWRZML7RrzFwpzpNkt0GDmTM2hqS8=;
        b=oplf9GlexDtjjLqmn8dmr76b+EiAc4WzYn3+AvIK6Y7EE4U6Szk6FVSNFYWtCGBcPJ
         /4T1Hvfqj0/RD4Gk/wQKqz4q+sz5+XG8oj4BcYaNy/X/WGbaH2tBOmz2OPWpJhn0X87c
         EeqzUDcrmWuBUZQA/vZqweaI0Q5e8Pvw3eAHDqDXGZUSfs4S5B3qN96nM+T9oK2nG5iQ
         ibr6u7kJUt6WaD/eQMashMZnlkZ2ufQx1CQ217LlD7eZYqcr6NWXsjFHom/jrYQCuf2k
         Zu/pX3YQuWLuJzb1/zzZs7bucn5qNMyRCEexv1E6vaiCgjdjcuOsxE78fUuIYtzB7ymK
         Wo4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626569; x=1793231369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l1CEXyVgQMbFVsk7IoQbzUTVIyGJIWJ7DnssjbN9Dfs=;
        b=Rc9+7aEzwocYivaBFxvM15513yEHgLne/O9U3HZ7lwpj0wyNYBXNf/s5CMB9QIe8Nb
         PdqGvqHC9DMRF6kpN+DrMuWn+sa5lfj6dDzQ9zjL0PF40/wcmijDSWhAiyMtBZJbmgR3
         SA1eXqJzPi5FB/GpaU9lGMZf63RKbt4NOMVWGZ7Pz+X7aeZXr/lC7CEAzV/wJqcsjTrx
         /lFxphokx5JtzeDMBes8xO0U/2uEpMve+7G2cITo1D/sv7Q6xlyR6XcXks5mGkMVAq+O
         ILgvMZogW1XUt+ps/pPQ6oyPngzKnNKiZ2oA68qMKcJuvz+f4NKSgFeCTt9CPuPe/b2V
         KnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626569; x=1793231369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1CEXyVgQMbFVsk7IoQbzUTVIyGJIWJ7DnssjbN9Dfs=;
        b=sPmUdvbM1zYx+Q3k0YFMH2TMK2Jj4PQWyGJqxfQ5oQnVjkSr/IffXVVRI1s8oxBL3b
         lcKCHzWJZuh4UDM/z7H+2awRKCcg+g8vHQvyKgHImJkjfKqkubS89n8jZzKK9gaCTgfq
         T5fjz1N2KlBEZq2P2syK64q7qU9KnDqeIfVLR7hJlOS+fIn92GEOel9fgC5BdKFWXvHq
         KkIYBGUV7ZRpHMV/Bx3yQ61KKBwmupdBOWPxQbdiy8bQXYfxQZKbmarJHzlYqrkmXWwv
         kUil8egj7sFYaDch/BSg3dC6WZd6EXqgPJ5rae0nH3Kvqhf/mkvIHVpkK4jndVLHo4y0
         73Uw==
X-Forwarded-Encrypted: i=1; AKwUvByS12CUtt3kOBr1pJIM5tRBHNwdKTFaTZhyDByaYEF30SCHq21mRhg0eE4Bz23m2C+Vbpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYItA48JXcxIPS/nv/gV3o3/qc3xiQ6mf7qfDrp6sEivH7KML22p
	f0RwsKF54uwfXOc+y0zPNkk83OUKLMnPCXW0DYBZrWVxsm2aTJKrq45NmxVCfa8VCxwC2QOoCcj
	kjxg8qtJ+GHe6aBRZCiSjikvjGNzjpMqmASYPf3J/ZWTIKcLvzAwtiwXBmt0=
X-Gm-Gg: AYBFou3VXHgG5J9941znzFbVFPV1pqomVGqDlUt9za2nTcIw5NKBNsjeEPzummSyrag
	He1cl8oHdS3G58gbCyYynjBGAmV55efknnb3CPlN3SRUQOlaCPuyRPUNVNWyOKwbllHD2ylJ4Fx
	jn0ICyUzpLC+vMA+ssv9l4D/JqSdutR4CwR0xFfyxUjt4AaTJpGYs6zQEINeg6RWbYPT9FbK7rM
	AXjJF4Z2M7e91DTiDIsdL3otqYv69L07bQmrbMjZYLvIdZSzRybhoKlTnPY7NTNi3Xc13YAWevi
	MEpx/ZDDpj/xTAnYuB486nrUHLuK0d+c1PaZ95cFAbxOAkoE4Fbi5OFCmAsTNyohoJkX6Nmma1l
	Y68wogXLXpxsZ1ZR+cEgkIK5bvrrhvm4maj18aWe/s43au6btZRq8fVhh/g==
X-Received: by 2002:a05:6402:a301:b0:6b3:b648:314d with SMTP id
 4fb4d7f45d1cf-6b41e0865a9mr15155a12.6.1792626568371; Wed, 21 Oct 2026
 16:49:28 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-8-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-8-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:49:15 -0700
X-Gm-Features: AclHuK87br5OOBkkIdzSeXjz2yL2lIy8-0PY-HaDQM0hn_F4XUKxOtzoFEd9wZc
Message-ID: <CALMp9eQmOcq0Edb6Txfe1NPASbY=3u=NSkQrVAbtqtecr6WWqA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:08=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Now that LBRv2 is fully virtualized, advertise it and report the LBR
> stack depth in CPUID. Gate the advertisement on LBR virtualization, the
> mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never exposes a
> configuration it cannot faithfully virtualize.
>
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---

In addition to what Sashiko said, I think this needs to come after
patch 08/12. Ortherwise, we can hit the KVM_BUG_ON(is_sev_es_guest) in
__svm_disable_lbrv().
