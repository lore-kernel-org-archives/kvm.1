Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F238E12D
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787961328; cv=none; b=YgxYvB5Dry1CR9z/3oASBQb2MvQlYfG5aiCHqx6qMUoyW7Ff90PTtBkUO5ISTSGMQdjJeBP+w6ZM8QAuRGmE2bqZcAllTWlDczqu763cyP3M0KUJOIHXtHQZ/dcMLBx+rzCHUOyUXF2QUxmVjkrHMXGIEKUo5bxSQuFQFWEbBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787961328; c=relaxed/simple;
	bh=Fc6oU0gFwa5CYL2V35yy8fXUOTX9m4M0XVDoHvMR/B8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrMr7SbcCbf7s3J0hpurLKpB5io+43CpNArQQr06sheQwu+HWP4w6hyccW9FNtK6X1P906yN6nmCxHis8LIBp/NStVudzzT9NHV57eOF8lQBYyAT9Lmj96lOiSyYm8SaV7cREcACWp/cDJGtP/ohugjtkZuPTB3vw2XNbKfE2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnAX9JiK; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnAX9JiK"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfca8558d2so20180695ad.2
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 16:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787961326; x=1788566126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mqr9nHpbkyUzPAQTiIg+XS18DfYCuk6G8Yl7jT5lYuE=;
        b=wnAX9JiKx3r4nknzhCcbV/qY2w1Gmyt42unbJmbW/C2IuT093ZGpftqq1/m/PoKE4q
         L2eeOlWlTMoo9xyvvXbFwBPd/w4miWsQbTqq61gSt8aKQIF42TymEddn1V3XIipkD4V8
         5myEahjkyMbfDCJJbWciHeceqg7NQZrjUSjCkIMHu1QWna4ShC+Lr3qzs/Qvzr4wzDQU
         1pCFhAfCICXlzqpRBWl28cC54y+ysnQgPn/xy1Sqa7BNw6teNHUwX5KrJ3Eb745bjApz
         QXpRGqyyxnrHwkaBdgUo06lrWsGeYKbybuo/KND0ea2helsh3xDUdJDx0tlSVnKE9Byk
         Elaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787961326; x=1788566126;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mqr9nHpbkyUzPAQTiIg+XS18DfYCuk6G8Yl7jT5lYuE=;
        b=GruZdqaqd0cMuFD16mlsonSgETa3cKOrQqgKtXYRIYpFhnQ5FEJMkh39niTbIgaVbO
         1IETYLfEgXLdJk5L8dtM8J7ujEASqwgy22YpiXwytXDPG5s4l4ncdvj0VLUbvLiCfKB2
         NJtwUmprQzQrk3uE+7xgS1whsqQkP64V6FuP9VEimvHa1jalocma/mWQR7fLoZMQ/bpC
         nLe05Y/MBnY7UIlmUVBJzMieCIJ3myMNZ278GLFeXZW2D+gmcALi4SsEFUKVWooq5nyv
         P7jSlw/Y8vQfcIErAylaA6UZxF+FNR6DZgWtAII/UomNHQoE2yutUbph2fmlwDK25ddF
         OKaQ==
X-Gm-Message-State: AFuF++kcbXysjGzwGuBqUTBfftBuKUaaB4ho/42UdkNipKvYpG8TZlhh
	oML6WXhINC+soGdC27RymxOdknNArdS9PLkAWqXHiZLAcEierN3QF6X0Yglc/FjO5pgvPZhITMk
	o+M13cw==
X-Received: from plri17.prod.google.com ([2002:a17:903:32d1:b0:2d7:3fb9:889b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b68:b0:2d8:d4cd:dc92
 with SMTP id d9443c01a7336-2d8d4cddf49mr47103025ad.21.1787961326405; Fri, 28
 Aug 2026 16:55:26 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:55:25 -0700
In-Reply-To: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
Message-ID: <apIf7eoMxdfV_7kE@google.com>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
From: Sean Christopherson <seanjc@google.com>
To: Jean-Christophe Guillain <jean-christophe@guillain.net>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Jean-Christophe Guillain wrote:
> Hello,
>=20
> Since yesterday, my daily compilation of Linus tree fails with this
> error:
>=20
>   CC [M]  arch/x86/kvm/vmx/vmx.o
> In file included from <command-line>:
> arch/x86/kvm/vmx/vmx.c: In function =E2=80=98vmx_init=E2=80=99:
> ././include/linux/compiler_types.h:702:45: error: call to
> =E2=80=98__compiletime_assert_1411=E2=80=99 declared with attribute error=
: BUILD_BUG_ON
> failed: get_order(sizeof(struct kvm_vmx) - SIZE_OF_MEMSLOTS_HASHTABLE)
> && !IS_ENABLED(CONFIG_DEBUG_KERNEL) && !IS_ENABLED(CONFIG_KASAN)
>   702 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)

The immediate problem is more than likely commit 97d65b544f48 ("KVM: Check =
for
duplicate vcpu_id as early as possible"), which increased the size by 512 b=
ytes.

But KVM has gotten quite fat in over the last year, because if we can trust=
 past
me, the size was then 2KiB when commit ac777fbf064f ("KVM: x86: Use kvzallo=
c() to
allocate VM struct") added the assert:

  but given that the size of the structure (without the memslots hash table=
s) is
  below 2KiB after 18+ years of existence, more than doubling the size woul=
d be
  quite notable.

Stupidly, I missed the failed assert because all of my build configs have
CONFIG_DEBUG_KERNEL=3Dy (which is somewhat frustrating because just enablin=
g that
config doesn't actually inflate the size, but checking for all of the confi=
gs
gated by DEBUG_KERNEL that do inflate the size would be too much of a maint=
enance
burden).

Given that no bots have complained, it's probably fine to let rc1 get relea=
sed
with broken CONFIG_DEBUG_KERNEL=3Dn builds?  If not, I'd just temporarily d=
isable
the sanity checks until we can look into this.

I'll dig in next week to try and figure out where all the memory is going (=
and
I'll add a CONFIG_DEBUG_KERNEL=3Dn config to my build tests so this doesn't=
 happen
again).
