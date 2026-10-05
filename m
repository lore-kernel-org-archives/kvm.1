Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EE547072
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168002; cv=none; b=oERuQj4NnRvTCngpaDGTPesqygG1U39qhFzu+HYe168NDNjtBGMENu15gHZh5Q0fV7EwCgTrnnyYN5W8sD0tuUeDHx6hs+JbeV038u23WUOyTz2UMY0JkHi2+r2Jr/Ocx3vaKnuSMplH7JUbpy4E8KXwyGOJ9WUoXI6a5NL0hVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168002; c=relaxed/simple;
	bh=VOGPZRYZ665kECnYosasWRGv4iW89S9j9spuV8erKuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HQzC61nUCEUge2A5WcQU6aDn1TFa8l914fzpFoRCNle/0zok2+Uu7+1xxrF9PibtIiAJJ9+X//QLo7Y6jC3n1L+QfGiz2KLOD2LmBRGBL0rTtW//xWUDx47fhIQ2xzNyntsxFjKP41fmu//nDFeVGGcFOAIuWkq3hK666kUUfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiUuQq6S; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiUuQq6S"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso2356188a12.3
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 19:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791168001; x=1791772801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9HTQO2rUlDTOnGrtLyq1XH041/gAEdrB3b/I0PgRl8=;
        b=BiUuQq6SL/m686qqvZa/eAw+ANmOIjVLIjpJRHcOGpO1Rr4wxGiI/kjl3RLC7Emw+n
         ofIrWlUws8hQ2k7EaYF6kv7Sdg6mYDbyuWf9DuS/gp65nDFo0kpsy/vs19rhFqN1YdlC
         Xtkp3QcBJ7fjztD5m+U8GFzTe7uj7+BBB31Xxz4C8ugHZmUQa2oBosf/NYTTjNFL1tQG
         c2E16B02FJQujmPx3f4IRQN3vqctN6AMYm9xHyvQUFHjt5JXnbHebUAzQm9iZaD5Xsht
         moYmD4nD2Ev2Chz23YgcmZDW1wJwyNKbZ2Ofq5moKfASrSJDVqFpJeZjC7bszS8E3sNI
         cUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791168001; x=1791772801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9HTQO2rUlDTOnGrtLyq1XH041/gAEdrB3b/I0PgRl8=;
        b=B94bkR8z+XAZSvSjhMvxf+8IrUvHXzPM/5NZkk6IzXGdME4GwOpQCevoT/1VQelNpR
         NToG2FBJCPTUN7jwF57ButXuDDFy0GZfdQ96KQYPtOYsSs7ruDpMK7a6TpW8Rrl1wLTn
         1nEfuoLU0GWOYO3SyroZNF4SFoN8RfqDXxSNqn6ch/r+tX/FvY5QcNFDT3VQ9JDOfipD
         LHiCbYyvs6eR9ESsDtdzBPC+MDsjVfD4eg2qQYi52GRnexvLTeY/R6rP/iofzprNap/j
         6HTOVCuMdpYpBZEwYVmXUlu3RLL8+mm/ZMR7+8NFmWjxdyldenRYiEfT3JKMxWQBVeii
         fnIw==
X-Gm-Message-State: AFuF++leQj0bLEan3tqbKB3SDppbpnPqDLwNBWKCDW9rMejdH7qdmQta
	7pbjIONOhbm4D1+QhZ7EQPjB8jiQJJK0m4UI3rxkL3Um1cbtNM0soUqJ32t7sdJJu/fhE+LKY0S
	qxT2cDw==
X-Received: from pfm17.prod.google.com ([2002:a05:6a00:731:b0:88f:62f8:bdbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e92:b0:3e0:651a:d150
 with SMTP id adf61e73a8af0-3e0d6b1e9damr5767266637.43.1791168000327; Sun, 04
 Oct 2026 19:40:00 -0700 (PDT)
Date: Sun, 4 Oct 2026 19:39:57 -0700
In-Reply-To: <h5j3jn86.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com>
 <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com>
Message-ID: <asMN_TAX-1_J3jiP@google.com>
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 03, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
> kvm_create_max_vcpus

Oh, right, kvm_create_max_vcpus is a common test.  Can userspace detect that it's
running KVM-on-PowerVM (in a not completely unpleasant way)?  If so, an alternative
would be to keep the KVM_CAP_PPC_SMT change in v6 (patch 2) as a prep patch (before
adding PPC support to Makefile.kvm), and then add a
TEST_REQUIRE(!kvm_is_on_ppc_powervm()) or whatever.

I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
over open coding TEST_GEN_PROGS_COMMON.  LoongArch open coded its full test list
for some reason, and in less than a year it has started missing out on new common
tests.

> (& maybe few others like vm_types_test) from that in v6.

What's wrong with VM types test?  That one really should Just Work on all
architectures.  It doesn't run on LoongArch, but I assume that's oversight?
