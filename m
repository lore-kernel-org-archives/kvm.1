Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103433121F
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712087; cv=pass; b=WRB6C2PV4fHtlmgEHI79dxbgIr+YtsiqSturBLSwXN/slDJ+z21mQT8yhicl5B9ApI19c2K89XYpsJrhsHXHB5OTsU3av8cky7Et/URC7x7RNMWKHD3h8835eOEi00ZeUz0Gk9Q/Ry1DybItJ3kuYrB4Xx+1obq+XkwNaNfVyU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712087; c=relaxed/simple;
	bh=6fonz5aCZofbcFf0gHADvqItIsz7CzQJCPoXLzLqI34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmQTyBR/xnOyBju3m3mIS3153go8KKf0IEApd1Q05ckYiBTyH8H9GAGvuAuYKoxTiznHn/aGbGKBpG+Lfq112v0og8mVsxPj63NNhGiq7Zi7G/Z4IZJS8RS+mHwTg3AwjLISJGbpUbPspoIJwFbYGiGEq9lPdN0uZXvzx5o/O7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW4pQ7MC; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW4pQ7MC"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c7ebfc7e4so1219141cf.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 12:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783712084; cv=none;
        d=google.com; s=arc-20260327;
        b=NB8bJoEiZqlGKJHPTa4LP93thy9fJH6Q0Du0GITQmceCy26KKd6ywgmLEzTL56V0TS
         IevHa1NwNjm/5BmZSNrhmJdQl7LtfKvQTRP9tQ457Oj4diZ6i11++M6KVwCjwSW1xKxI
         MuV+Dwo6a5t2Q/Rm8wdM5eoqxkcJgi0yrvUj3WFuMLtrwDrdmdWfNwjFXPimtKn2+roE
         NeDjH0MLLLdc5u2kYO2itEvAySF/NKuNdm4AzUw1gr7UOBMOZES4SxB8Pwl6VZ8u+vJd
         oyebO49jzI8FOUmT+y4Ug+2CK/YzqwYKm10/4Yi5XcLdWZzjJJZBdYSgOMKjm8XXV7Dn
         2PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6fonz5aCZofbcFf0gHADvqItIsz7CzQJCPoXLzLqI34=;
        fh=1H7sBDXd3aPqp3ALX33Ge6F2oJmm1UdO0NsLqFJSrkQ=;
        b=R2PeJxUuKdBgmw6IiqZfJUPjJzRvmbCPhwMHeR8fwCr3MVXzKo1EcgH8O8t2lp9A0G
         dUX9F3d+D1uXEN3rjJuC7zKul96TQG1ZwWaqgSXAl/NSD0BuXGaE5519GsZqtr6UAjvu
         SoLiH7HGvhSBEuYyZQ7+PDFHUsrxwb51V3pT1Gyb7Qb0qhsWz/q+B3jcIoaa1W2Iy8zu
         5z210on4s5/XeWk5qToSZQXtPf+W8ktSIryJt/h8WduOCufC4/60Qd5qA7o+VDUjbGkN
         3lpU9/wlf2s/ToP7RRYbrUdh4UcFYrpMs2LKZzLUw0XyBY4i0aZwxIj36H/U8oyO872e
         imSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712084; x=1784316884; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fonz5aCZofbcFf0gHADvqItIsz7CzQJCPoXLzLqI34=;
        b=NW4pQ7MCaunM5mRMYRvY09UOYczJ1apd8c+HpdF2558fWwb9XxTYTIc7MKwxxw0Q/8
         LnmlzmlRRqV4V06nvBcbFFGD8VBHhtfIYqGmcoi9qCj8eHYI9IvKHe99P8vKfALAL/qj
         XVO/X9JCi2MwySY+/Zm7jWC9WQE1n5s8/hF1fpklNnFyH929B9pPE8hPakQensZto+ur
         t/zvD0Mx9MZvhbPaSwmJLziCieGamC6if8oUNzrziCq7dYyOKANub2kn7TqsaWqan71I
         oSDjA0ehT6ON3k4BePNaDwWi0eMrobuhknLQcrd0tCXfDnqp/mWz5ynxTygDiRVSlYp/
         RoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712084; x=1784316884;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6fonz5aCZofbcFf0gHADvqItIsz7CzQJCPoXLzLqI34=;
        b=I/1RVYD1kOcXAbqSatX8inrdxsEZUrye/YzpJqdvxKuTNkzF2LTqgZWHzN2guNlV3F
         zV2a+0aLl5kNqjlbNjr6n/faq+wGc4IrenWlsg2oLrsa3+9YJgIWDbjQ+EXmyPrW859r
         oCGVc1Nf3YESOhHDLsGdG5dbtkhZ0NbitytWoi9NxsId2LLFHivARY3yAfuJII/f8+2K
         ABZznItUm9qW/xDPaDFb21hir6Xh88huPCxL3K45HO+5zmsIKN8iaQtQ7KN8HsknPkWb
         sY6HpToJbvGwPgimX5Cg5oatg1iPbLFxrWwh64JdGCWu2eYdfoXeCkiUq7mBbxm//h8s
         50Jg==
X-Forwarded-Encrypted: i=1; AHgh+RoPeqYKkljxrqNCqRbYWWU2vrBY+kyc0Z9AqVs0U+wUvO2xm+h2w4R0if+DrV+E+unKJpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQ6oHNHImzb832UPEQvf0dRlRnGH31xW3gCLEiIf8HlRHr1xC
	OaVf1pFUwgX+R1ScZ1JC+2kukputQk/2+lOJWCpAOtS+jxJLKyia67ip0dw2+npvR+aEoAjRtvE
	KfIILaAuZ2iVucSFoU9E3WdRpAMV7sLwxy02D
X-Gm-Gg: AfdE7cmfFqxTd0pUPyjckMHLltaW5VlZ34uOaCAF/MaQisrUEtV7gkKgzYjZ3IeDgR0
	wLHF/g7HxgnvHHtygxK9PZ9U8aMMG/2k64sBSq26/iTSTNm4G5boiQInfezLZL1aVDFs6dUv0yY
	SmgggYkuXeFzVwaqRiWvgulY+lqqEKqezrlMQCYWLDbdK44/Kmenp6I3j4RUvwl3DiDTdvTVNq6
	grwcxh7wp8lgklAf36985bupRlQv5lyhA/1+/LaJVFUImWFBH3unADxn16Q6sRbdGBVoU00sZ3B
	n9rBrg==
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id
 d75a77b69052e-51cbf289286mr2490001cf.9.1783712084308; Fri, 10 Jul 2026
 12:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134055.16432-1-danielpaziyski@gmail.com> <alE9J1SjQSNHaV16@google.com>
In-Reply-To: <alE9J1SjQSNHaV16@google.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Fri, 10 Jul 2026 21:34:33 +0200
X-Gm-Features: AUfX_mwDo_rX3BmkxFZv5f-bopplmQ3LHqOjiahXUtC7VIoME6IgL7LAC13deKs
Message-ID: <CANukVxum0uYEfyu3gb=xef0D0Pf0D6u_bEc0Ye8RPeukCG4+sw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Thank you for the response!
