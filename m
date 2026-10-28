Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196314;
	b=yr5M91UR1WdebcupUB9ybzK1BXs3/188T422K7VzcCbyY73hfOtBVqby9z/Pz7nnNX3u
	 UK1463AyJpI59boeesq63IiLkdqK/v7qyxo75DUXpZ7ULIpFypKhJMnlp0wtSMFRlNO9Y
	 KgnSfpbPHskQOzZi6HTm/yhCet0roML5VNV43Jdo1voLiFNUW2p+Ek3k6auAD37S0EO7P
	 ONpq5Bne9SSLNVOlm+m6eH7IN+oSj4y8f6rSoz3aAXTWE4vjZ6KpqtghfxLzGm0BXiKRD
	 LdE5fcNe+kdp84SfUQTy9vfGMKGYvcVZnhihTXOgUAAd0DvEuoyAtoOpOIsxMbnRksA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cGXU/zFPh/QfHX0K0nlme8hTRMwERinrVSJ748v2N7c=;
	b=rSE6aeMw1SI+NtT0g2yl4nOID/xqhWsALlMGKXeKB2oQluJ9YaRDW9UhReCbRHUcHZXp
	 hpu93Pr7CVi868vVzlm9cym8d/emlu7fqto0GY2Ij/RBgUqhoCla86Puo0YO16jt14uQR
	 CaxGDHhrcxE2TagYsuzo/bxvsdYi5TpKgPpqZ26cgYExa1E9LENyR7HS2bhDnecjYW4GO
	 eraXLaIcPiTjeX/zpx4KF9DdRr2UIHjusk1sKbQbMVf8whTEHk/gVqPM6zIKUzhjQgtHv
	 95f9ubVeoQcOBBRSM+pwlxCBdUr0TZtujRtOj+0z//KtWIuo9JJBg5sT+dwHI1wJzOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yhh+Ujbn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EA606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yhh+Ujbn
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so9511a12.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793196313; cv=none;
        d=google.com; s=arc-20260327;
        b=CuD0mK7gHt2U6L1bl1EnHQm6nbJSVmNP24tSjRqKMKsQUmd5j6Bt+YmwxvnzL+hxsr
         OAs3kdyjzPpZNnRahLfbkUZc1/Rp5BrvociwHTC1IIh3hsORLtB2cOVcEOTQ/Kwg0SMq
         PsXfQxwPXgkFaLNA5WmfWCxrTsbZd73MUUh4+fbLFyGf4qbJvG0NjxM1+w7mqeuClyPd
         34MqiOS3evC7H4YB06fsz0qpRKJEjad/UYHyCemYawfTTXMGSorcUM+9qUOEGOml6+F0
         GDteX2dNYySkFYjEuJlT1+0AGJp7KPAGX9273LahP2eGCXIja0nHVzp5rTGKjaGsZwzY
         jMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGXU/zFPh/QfHX0K0nlme8hTRMwERinrVSJ748v2N7c=;
        fh=Amy05EOuriP7QA+H43O/aOaVSrTmiSV8oOrVUghFwsE=;
        b=MVtSeeepIuazyVHqyabGlG2hyF0d7aEOL5UwOa9cLlnjQMgOEGcagd9zU3ZIg9uQlZ
         ADW8GvtF1Yl36nJ/JHPne7FuANu07/wJc+pLcatQLWtXwjBWJXVzdkkjtsAbO7ytgSay
         rqvBQUzsuqdLAgIHcuuZt+Un4hlELGwovHmkywb9YadKlC+NaHFpCuGuOktpWeqhh3uz
         8tB2ApBdki0Wvwm4Stnm1S+qOC1BVQvP5gyeGHanVaosmXvuSDs1A9cdWOYF+dlVVME2
         C9f2sVU1pP7mSunVeMVqe3Xbyi2zyBbcK92KrRtUdL+dvrrV/bSDNEB4NODgRGNW7jHx
         RUuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793196313; x=1793801113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGXU/zFPh/QfHX0K0nlme8hTRMwERinrVSJ748v2N7c=;
        b=Yhh+UjbnvCWZnvqiAgMqv2HtaYmX1l+fS5ejvIu+T8UA7oXrydYu9XNxu2r7wnadza
         1apF9YZ5+ObXvlh+6hV04yhVS1Fw3h+X/jIEzuMaQC/F66OG0SG7zMWzzOEr6hyN68mA
         3ifLYbZqAkBA6SIFgWNbxNs5s2gEN30IJBRAjewx+vKPu22SIPjd/GN8pPfGjWjore3X
         s0MpB/YJ2h01VHF7/nP2Tjey6sJCI8NqzrM5CAEqotlAdwpSjsTEfeORoE3w5Mu3rN1s
         IgOPlNzPbm885eFmPaCeksTUwLZBDYi5qzM/wwHP7x73q8rk5zJn1OpsW5HjpyNAUhoG
         lzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196313; x=1793801113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGXU/zFPh/QfHX0K0nlme8hTRMwERinrVSJ748v2N7c=;
        b=h7usHTAJQ5dw9wWN+ZuN/kyIHuyzZFkFDT2lA5lNJyYZb6yyZPHqnRM1W65dEadipH
         K61FK73s9qsv+ULdn1Pw8eEjlLlyU4kNYYHb1BckNbNAoKBaBfQnVzrL/bK1ePoDqzzn
         ymZXIRde1erAlHofeXucOSeHRTN/3LSfaDiMvni8M1QcrUxmEwDsBQYJsAvCX24dD360
         VNaI4+3HQgt88S0ePdC6MxcC0/fqck0zybpkbCMU37nX+KWdG92ukFjWjI3M2cN7VOSm
         2YtKIaNv4+pzN+XVdh2WWhKJz8ICVuxxUj8341olnhZzQW4adrM9PMPMf1q3srg5gdPQ
         5LeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkIFil5rt7ZGPLXXoRi4XSb8XxnKdpaC8kn9HvkpeptFqLXK7DDv6kiyt/El9G54FkqNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiwORPCaoBgh18RqVIMJ4U4it4Zz0tobJeIpr6EsDLezn1IY9l
	e5lBdOfa9PTtgQiidlXnSctrKwO21Pc9L9mWZhcD0w2EglOLRh2BJN4XClxiZ0/zYJrIUL6C1Q2
	E612Z3B0XMgjOrW8d3gYoqR6LwO6rHImIRC6oNnkv
X-Gm-Gg: AYBFou2WHgQ0ZyUASN+EdB/PT6yihG8UrkN7AaSwC4xCvHE8mT2jc3a8ePsImwzNUTZ
	SCHkDmwnedwGOostBYuy1AOX1au28M2/V7vC6EG8ZBedyj41SHH8m9k+dBoR2wSTwbHczTInuTr
	4pkqTgW8HoSusOwOgQt6ZPP0EYbBLfKncanJ1uUvtPzy681yQk6F6ugN5KtkwmSFEb1oqm51Zw5
	DnRZqzrR7AAdBn+HX18KqnNXdf8C7oDYHGfIvh6HPCa1Fg+ggkpMv4kTkm6hVaGiX1grd0L6t7C
	0uw97g9VLOTxtrvJwtkqYiEglZ5Qdbzr/a/3f6w4z2tyWOvHGbR2Vb4WubZwgUrABcbm1P7ObCy
	690nYp7ucd6vzwcHWJ4vSeHNUa/Ayz0oE9UkG
X-Received: by 2002:aa7:d80a:0:b0:6b4:6725:f2c6 with SMTP id
 4fb4d7f45d1cf-6b49c12b944mr57975a12.13.1793196312136; Wed, 28 Oct 2026
 07:05:12 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-3-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-3-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:04:59 -0700
X-Gm-Features: AclHuK_P_Tsz05675NXoOMY2lyrRrl7vfF0oUfpnX6EhSHO04vGfW7E2mOJpauI
Message-ID: <CALMp9eQWU5Nn5QS=4hEbgL-HD43pMmYQfb9y1vnBJnCcrHXLVQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] KVM: x86/pmu: Rename all_valid_pmc_idx to pmc_exists
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
> itself; rename it to pmc_exists to better reflect what it holds and
> keep the name consistent with other fields in the same struct.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
