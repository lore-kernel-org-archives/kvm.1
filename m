Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A951588E
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984207; cv=pass; b=G+oKzAEb+2ELE4oyaM54sqlumpkd/e6Vvynd8s8l93bc3XhUgss+Mi2njdysrJRfn7Ca4qHuwdGMoR3YMr9jV+xn3rYzOzKsZLBV9Y+fEP77fXrOMme+PvPoIWFeitPaSXUOg/yBRTMepUd/NxYLwAnL6R2Lk2qqKQvHOlMo3Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984207; c=relaxed/simple;
	bh=9N5l3xgliyI7DgwvETpVVXBnUo7bo+QHYse1Sw6uPvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoF0UI3iFtaqvw98aKWTkEvfStfTK4XsLY58Gi/EKpXmI9+tirjYJbB18ILG6sIWvI6fua2lnNuW6Djp00LEeQADtL4yrPGLbCluN7FqTWI44Py2kUyEWzSQ4OQrKPeZmdsXdMDMGmP43ePlvA+gyZD+JE7c7kPevy5gAOgfYVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJddgj/S; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJddgj/S"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso38920a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 06:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984204; cv=none;
        d=google.com; s=arc-20260327;
        b=H1BNZtGUEJNhqOftEp+Vl6uErdreJTOOuJ6U7nlOLawfqCBsElnz8HUApdmy4VxoBj
         mk/yjnJcoFBPdLtUuWqaKB+LjOt2Cm9Z2OP6DH0ZB5fquOtl7VpEwXzRLzYmodfMZUIY
         MU0k3G5Ta0tByplLzT0XmYFlJ3r2969E0AUvBL+hg2lZFcY4wzDFCW+G0ILaYiR3GzSb
         cOf2RLTNQEcbFVtRhANJwqgpNDR5nlRIrCxrR4HyJIBCt5knPb4bKC/F79gGio9zSK7W
         xYnNLrGYGt3WBEmKMcGwj4GWg5Layw7wROM1kr/q0oZhUUuOI9fMgbDBpK+3fMxeM1lc
         55UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9N5l3xgliyI7DgwvETpVVXBnUo7bo+QHYse1Sw6uPvM=;
        fh=okWoJxM44p/HTIRTY9dMW885DY5G4AMGv5BKhjx0zAA=;
        b=sxuQCS9pktIkoQWXs+1NWkMaEX7VYN5Ms6d7JNfZPDmcx9j//j/KcxWbxI8W8yvqtq
         3A7z+Q8X10RABUBjzBEUSlJrdSEGGIv5obcAU0PUJz+sSJ2+NOHPyVazIzHf9OLKUS7S
         MAXUAw6hZz+4iQMoD2XmvWYCf9WkTGqN/5zSqBh2JtBHjsFBjmdfiqNBc0PejX2/LOs2
         1uxm8GLmhya1kuaoW6c/bSjlSx+YzUpC9va10nlwieF0nFhuRgmciVyMEIozP+1065d0
         XRs/uDSxouWWSFk60tvngoQjomD8N+Ymg31PvqHh+RDR+ZDhcE9ll/IqWOH23aWq7CPT
         eK1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791984204; x=1792589004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N5l3xgliyI7DgwvETpVVXBnUo7bo+QHYse1Sw6uPvM=;
        b=DJddgj/SQOx1k6Gh07ID22QLRGPzmjViCjicIhnelsO7J6s7cl1WKeI0EE/Fs8XwFr
         XIDve0/4Lg25OFfw/JSpLJUANTEOQwJ2n0/5LpkHWiTpJfSPLYPYAdUo8oJvwd1WbvR+
         ctk2JcErybtP2vS+/6T7Vj4Xx+kq4xUABU4zgRR/IJdHb4Tj70kgq8FHa7ZN21U/w7Sd
         VJ01rlLDcHtwrPWAvsbarq7Re3sdnjqk4Xa1U8zBuiqViIJogqcSFmLhOlGXR9QrGRWT
         1H666XMba1SzADWNu8IDGBBH/QM/eo/BfcUoWNgHmxpHh8Rd+S5Z2c6iLJR74xGELl8X
         Gj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984204; x=1792589004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N5l3xgliyI7DgwvETpVVXBnUo7bo+QHYse1Sw6uPvM=;
        b=pPw2HD4dDBOoLOmnBIg6DkTM1FkJLmM/Hs7rsDQZMWfBZ/I4pTXcqRZRSOy0G0wYrE
         ay/mSOrpXLwE7xQePpXF1na7/wbmJE+Mld82YxgFGYP6FWp0tOISscOGt+65GWPkEmTF
         yGLiz2LA2s9oWTbp+KzIBfiNlBigXw4YoHhJmIcbR2O38Ydhh/+R9hU2i36lsR3zCxE+
         Q6idrLRvlTzPV3MC59cP6mC7HTPDi1octwYsKoV9AwqatoyaarXWB/EMNtPrtk5o+aPA
         oTFAj1m+LhWEusgHmqxgSXWI6unaqMqRFRtjHBtQi9oE8e5R/fD17vfMouBtgumnK8cf
         5KHw==
X-Forwarded-Encrypted: i=1; AKwUvByYJFAfwl/jiYSsjDhvKP0nmlJ0eKZfAyfaroYJX29RzIvn8ULSxmTYLVZ6gvRtBuwVAOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF8h9TpaU3UtXiQ1fvUrEKAZYoWW6q0EWg0ip9n/AL+7ZcxJ4p
	vT895VPj6VHlmsKLdxYVC/r+WIdITffwbWGSVaUDuDw2W5Po9tFCJlCqSfFkHd4i+APc1O3BmAG
	wCponOcd3n0rzq+QdW3PTdWL1O++9/04UgIy0PlYT
X-Gm-Gg: AYBFou0DfRVoJWhvr+O2Z0aWyeTCfV92zL/Bx2RmJ2T3hDV+orNz6ITDQckzD3Jbi39
	mzAK4QSgWFrT+A58uTuNUpv1HIf9XVWrD+i8RWnGqsKO2nwtmvgvGowDhhP1yh9GInNra1A4qt7
	/4bHofc0cUpkoP/JGM0lRhsAdtin7FlpHLfXfM792g5lzgKZWnkJDXpUdAPZnjc+VjrqumWbSRr
	4jgPQywTLbkRxM85BJbtrVlLGvKwDmBmD21CW2+9+ts2kwZ1V07kgjPVgvPFG9K2I1rTwpbnDOY
	Ycm/2XdTLzy8GvANdrWzJELTFcFV/pHJ3VY0oHp+/WwxsObdLQ8r7VM=
X-Received: by 2002:a05:6402:22c5:b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b209504430mr47922a12.0.1791984203271; Wed, 14 Oct 2026
 06:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 06:23:09 -0700
X-Gm-Features: AclHuK-RlhwGNQ8xFg32XTm3ZB8N_AkFk2N2sMtMgCS1te4fUNZ89xFZDJbQgpQ
Message-ID: <CALMp9eSuH1xe7PQ_WtE9DjqWjnKanFD_AFiiR9rEYkSV+sj45w@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] KVM: nSVM: Optimize nSVM TLB flushes
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> This series optimizes TLB flushes for nested SVM by using and maintaining
> a separate ASID for L2 for each vCPU (similar to VMX's handling of VPIDs)=
,
> rather than sharing the same ASID and flushing everything on every nested
> transition.
>
> The series also drops the dynamic ASID allocation scheme and uses a
> static ASID per vCPU (or two if using nested), bringing it closer to how
> VMX handles VPIDs. Modern CPUs (Rome, Milan, Genoa, Turin) advertise 32K
> ASIDs, so there is no need for dynamic allocation.

I'm not convinced that this is the right direction. It's almost always
better to do things locally when possible. Why not keep the per-CPU
generational allocation, but allocate two ASIDs per vCPU=E2=80=94one for ea=
ch
VMCB? This would eliminate the need for a fallback ASID and remove any
possible concerns about contention for a global bitmap. Moreover, it
would be much simpler to implement.
