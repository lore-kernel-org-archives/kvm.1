Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07613F9F5D
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468035; cv=none; b=BUFqkPZy7IsteSL1d3pnMsoaXozH16vCXp2nX8yEzmJ2guo/2QTJ+uIY/bOru1Z5CFJg8Zsoy4XycHVxPtC0xDnGpN40ck0LSA25dRua/5bnoj6NeTxKJ6kk/KcjljGWBBdD/U5YBYpI0N/LJSGAqYy5+RrYyJjCjAeu7A0yVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468035; c=relaxed/simple;
	bh=br4Q/5Zkdoxf1ZYbzi2zhNKQk/fuGIIMoDVDCqYOvec=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BGYE+4HeBmTQQBzLM4l3mvN1LzR4wyLMz6LcLLF5EPYzzBoNpvEhOLsH4SkCev31HkuDPxtdohVUQ7BErtinTSyU8ZXREl1IREafun14gejDie4eRE3cml8Oio2EDeNEEB9NPfzJGPe16Sp4w+fNyHQHyjqwRHaeqRhyTDl3EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+TFFupz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+TFFupz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf114b0cf9so35203575ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780468033; x=1781072833; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FsWw+BRaEfTe2BSzSpq066D0ULR8rb3630HXbbNfz04=;
        b=G+TFFupzCbNdF3i5DbDb6woQdwwrx11zHf//h3dwTPe8HiXAdLqI8L9P/BHw6OQRb+
         hR3iha1fuQu8ZdJMa/s4PRCm6hh6r5Z1WRP2uoSjC+jSVNSJZq2K7hpcyxgqMouh8w3S
         eM+6jFl1bYbeM2jcc1X2uyS5hj0Yl0bpPgOO/HLDy3q06PpdC32BzSuLGBYLTOzoxqfu
         Rec4QVRaKx2mtf0Vx2tbbLzE8vC/iX3bev8xe/ass9k1wpwz5yT6ijX43jdnz8UO2eeN
         fOubUiE5rUufkGGQIbd8IPBc+H4vHkghDpkXavVFZKfbwUthzno5bWnvepkF8OsjjUam
         q0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468033; x=1781072833;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsWw+BRaEfTe2BSzSpq066D0ULR8rb3630HXbbNfz04=;
        b=Bc0kybvwYsnyJlVajgyB4ox3PduNXRnRehWA60KS4GJ/Tp/ijxv0nIFWHItHtEJwx9
         M9ihncyUrN60tQk+o/3JnciyIK+dYsAP5MI4ogv30cvm1GH16CgayEhQr9tyALe601fT
         XGPCHlvf9GZh8zR4ZYdgeiBy2AMW9gUN4wwkgemc8lMI8PdGlBGAzkrXFCwHIMCnOL0/
         mg0PumvzDMAXo/8ALLYrlf7C3L8Hofz+hkTd906I2avF2d1lLGrwHoP+YnO7sMAHTRmi
         edPP1D+5eCYMKU2HVOeTzQPQvTPNVqBwYYilQlWCRlDIqmol5Ce6r78bXatoIS2J5lyL
         HpWg==
X-Forwarded-Encrypted: i=1; AFNElJ9kHM1has+jxrUOSrV+wMFdVLdyO8pAunxmIV3SR2OR5YVYUb+2BJNjpv7NisEYIzC44Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUE2PWDBY8wys/R+5YANuWSUCueQ5sMM7ormk3NvcjrZB6ivU
	HuWQ+5HeJUBKr56CYQsAEWgUSRvDeHBx1VP7SjkF1wf7SgdmuC2EnkkC
X-Gm-Gg: Acq92OGMflsrPRZQVyy1gvfaHFdGwyAkDaHvKLxTlkDwAsGexZhTc58GBTX25D3/jr5
	U77HRFG1txOCQIvsQeYJ3VDPYeyz6Bm9h7dmMSp1W8zsJA0dDJ9tG7L12xDr+MMv72Dgs5WMNtJ
	nP4iTmP4+hPhJI0w2t1UzQ3m0MLvXJi0W70/nDcZWm9q2VY7CfQL9IVstCUlLGGTC0BAEXAGNaC
	pZL1mzWQ9jzPlsw55D29YGDv4bxdpLI0lymLptrtjlXc5tvLTY0ihRWg5tk76Mzm+GwBuW5wCx9
	woyy+/6W3+PA3piS8dw3dJTm4iu4hrww7lDNIB4oRzANwLr7tso6+ZLD5hhgqTQREOaZjbxOm16
	lOCaZINMaMRVin728D3zQ0NXbL3/SiyUqSXsTjFkUsJIRO9Wsgfw6w0WNBucq1pOLFXvyDkMNCA
	rXLomR0Fh8dhQZW3oe4azKbHlV0dOxh+jT
X-Received: by 2002:a17:903:3c45:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1644ae17fmr20198585ad.32.1780468033143;
        Tue, 02 Jun 2026 23:27:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm12978885ad.59.2026.06.02.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:27:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
Date: Wed, 03 Jun 2026 11:35:55 +0530
Message-ID: <bjdsw43g.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com> <pl2g6xbz.ritesh.list@gmail.com> <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com> <cxyewhx8.ritesh.list@gmail.com> <87se74z4a6.fsf@vajain21.in.ibm.com> <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com> <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

>> amit, can you just post this alone as a separate patch, so that we could
>> pull it for 7.2 merge?
>> 
>
> FWIW, b4 am -P1 <mbox> should fetch this patch alone (and not the entire 
> series), See b4 am --help for more options to select a subset of patches.
>

I agree, however as an FYI in this case -
I had few review comments on PATCH-1 here [1] - which along with the
commit msg changes, also had a code change involved, so IMO, it's still
a good idea if Amit can test and send an updated patch separately for this -
to be pulled in for 7.2.

[1]: https://lore.kernel.org/linuxppc-dev/pl2g6xbz.ritesh.list@gmail.com/


Replying to Vaibhav comment here so that we can reach to the conclusion
at one place.

> Hence IMHO, this patch can be marked for stable tree and potential
> candidate for 7.2 merge window. But dont see applicability of a 'fixes'
> tag to this patch

I agree, we need not use a fixes tag then. So, we shall mark this
with v6.10 tag then.

Cc: stable@vger.kernel.org # v6.10+

(I calculated this based on when Power11 was added: 
git tag --contains c2ed087ed35ca    | grep -E "^v" |head -1
v6.10
)

-ritesh
