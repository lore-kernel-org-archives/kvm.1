Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA952836F
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991668; cv=pass; b=aK+NI/HS0WaXf6GHS+ca2FTWNR0rTkTEKSnFkv6SMTaPKRxVNJc6M7yHHsV5dO7YVLNP7JNlXbjsEQ/eOf7ecaYzfXp7j4An3+ZQdqaIOTSfdA+SGgxChco5l1YOdF6lU22tAeHxdi4G+SDxPu/oW5C1eyTzmzKx7eiqRacUShQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991668; c=relaxed/simple;
	bh=z+oLcorVuCdcj12NCEOazC7cPT2nVZcDJZDQLFllIYA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=novu0kBb+e4K7Cvuy1HUqGL4dp+rtS6z/n2JxN5ROTxa72joREnEPnP0GSkDP1S2D7E9FL/xGDCAtPnNPGnlQ32WEMMlh+fR0ly6HT9/kRQoPHZVCJYYvuql8JUCDv5SZbfBqU6oqicGU9gdk1KtZS2BMaGR3egDwCbcpjxiG9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+MSKK9z; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+MSKK9z"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso176688966b.1
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784991665; cv=none;
        d=google.com; s=arc-20260327;
        b=FZYnP/BaMZ8aKf5JO2BHt6ivR5+/s8XvKLRuE95arGbLQBipOUFjySM+/IadoSJ1p8
         nIPpNlcqoOm+/ANu/xQlmsIkYi6w32CfdnpbbvCUzd/nCSk7V9CyrlxQLNGufIYbZEXI
         VAolSUhzy/eCmSOa5zdQanJ8TfGkZdIviOAWFDW89sIYVYX0K+JntfJPiB8mEQHl+BwR
         PKIr+IUscAnew1ute1WV8zHUsKotY/RydoQPSH50e6FSv6TkpWLcQP/eoBCgUuwPE3K/
         EfEHCk3WAvximPHvYHbImt9PIF4VWvziq1129ZWBwOwUz6GwXlFzcDdCHJ2n0L0VwH3B
         rUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9myqwg6Az/mwJ6BBjyDBGazYdJiw+ix+dFgCSF+OiTQ=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=I0L2L4aHF+TxOnG8CX/dJ0UKxzFuuKJnZRu+6UR+5byFxf29Qb1T5cbge2qNdqQzKI
         gjgdg9tpZ0WEhFu7ukXmPl3j0FLUXTEOiQ1ZFNA9gqox80/HiZEq+KmTQy+EoSzYbmHb
         A2gqEY1e3yHyNgobJN5dVelwOh0fqcOzg4LZ5SZo275copmfgc4MGtjv3uoDKXEyQrjV
         /K7ZGCZUntdR91qy7cIhvF1JrxUg3vxVQICrCDrCbhLJl5gvDODz2v/K63v1ToP5Xzqp
         ahRQPAq0Ej1edJNCZkPSqB7WUZjJUF/f3izonrBRE95nZdoCE761Rbtzk9vsTMyeueln
         MA4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784991665; x=1785596465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9myqwg6Az/mwJ6BBjyDBGazYdJiw+ix+dFgCSF+OiTQ=;
        b=r+MSKK9z+pM6c7grKspUWJlv4xE48T1GaGop9WPkFt0A3t4iPL0CpZ+/CWZFjAxdI3
         6bjn10A7GpGdYHWMJJwj9g6ytEXMNSfzYiU8Q0Pbu8hQi0WUJhYnQHInJwdO2LtdT6v8
         fm2eUq+kUxtCD/fkqdy4PBhqL4gqQ8yHoQYUso97cHu+qmPiuUijfJ4S2C48PbWubBAC
         4pGIT2DUBGmkI0z3fMPEByYM1Kn3T3b9gygws5/TAvtUCC+BQKv+GlGDtlGt5C6DRVa+
         7Moyvi2UeFtN21+sITVyrt0gEoO3ym+tDQpTUBeOJV4mz11jdifAS6R1GuoO9+xl+V2N
         wtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991665; x=1785596465;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9myqwg6Az/mwJ6BBjyDBGazYdJiw+ix+dFgCSF+OiTQ=;
        b=UN31x3bkSN6aBA+4AFTyuKLCh8bWyjfjd7VQ67kVN4gJE5PucMbBDBxbR7pF8Pp0Hk
         tS1B6iLvbsW6FR8Zc8pIfBb3cGKvKhBc/9w/NcUc1plp2B3BoRdabH1YEGgiRlshLqgu
         +yJMCrju20dHUALOAdw7K1X3n6fCXRXgvs08VY607BzjBd0XtlhppbY/aOWsFeyA3A/B
         o/RdtUw6GSAA+f054osdbP1/RfGZGM6cCVzmWISBR86nvVMlUkJHHl8voNbWrb25u6b/
         /EqnBX1EiQU66chezvwjsKoys68zA3ScyXHcieCGD8wEMDeCRCiA+7lOM8AoTdbBRBVA
         7Z1w==
X-Gm-Message-State: AOJu0Ywsuapjoln3GlS8FQEPB/zLODYuyfdnCem2X3P0tQQwdSyd75IN
	klXAWm+g+7Tw5fXsRUzOhFxCyKYXWzJCTIgSy4C0kNVZW9kkoHVAYErelCxlCmlcUfACpr/qzqE
	puGZi+NpLq0k7obk44xU2Sng/u2uHAO3fXDsrYyBY/iakINjumRnM0gBK2lc=
X-Gm-Gg: AR+sD12XJ9asXRGyD7Sb+d0bmW2TyYb9qb7BxLZ/pS+86U8KdQMr5Hpdk+2zzVwFHD9
	3oJYzDSoT9cksMOZhbnC/byURKkQt197MPLx83G3j2x+IbjPf59xEeQO8MZSKCvY1koQccrl/Ol
	teclYjXpiXDWVHVG+yyCouEYmkU86O6EN3riPfFlK09KBAKi0xQohgAkqB2t/jpcfZ9Si9PYgo+
	4Zj3H+tH82ICuGj2580/8THL37DwS7n7Pby+Z2oVLZHfwXkWzzDVF5umXTciYWxBt7dgGjhhlua
	J2pc3WWXphJq+uKXQBQoy19JNyEW
X-Received: by 2002:a17:907:8e0e:b0:c16:3074:6593 with SMTP id
 a640c23a62f3a-c1f1ea22991mr102958966b.12.1784991664596; Sat, 25 Jul 2026
 08:01:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:01:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:01:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-8-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 08:01:02 -0700
X-Gm-Features: AUfX_mykhiAfLnbh_vuB8cLEw-nIdZFst8uyz7k75RYrI_FOm5vdCrAUm42uSUc
Message-ID: <CAEvNRgFD9R=j3H5hpg1jGyFWgO_hp8Jokz96bMNykbDRK0m2ww@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rework guest_memfd's prepare() hook into a more accurate make_private(),
> and rework its Kconfig from PREPARE to a more generic CONVERT.  This will
> allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
> between the "convert to shared" and "reclaim" flows, which are one and the
> same for SNP.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
