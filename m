Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C185446BEA
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995397; cv=pass; b=iI0dirwMYfh5TFCX59Vq49syYdVy8PnMbjPtsb4F9Rv5CG4EmYhRetK7oyFVylV6XzWaBInR+7XVGfiR6W/JGDIz99kubUM/Dzdzh1r3sX33wWuLpQYV19uDiLfjT61qGheKtmXbEH+kUW3DhYt9aUCCcqNbt6Dqi5SbggWVVnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995397; c=relaxed/simple;
	bh=HXiVsDK4HEWAyDApt+QKqpShDg89TTd7E6INOjLYEDw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdL7F5SPEPGgcde2wK7g52vzw/Y8lv0KPD3yXJBDDuoHDVhUKnQvmxD7gYx9E9NfqZggAAC18o3/vxMuNSahUaGWBUgALFayvKyIya5bGB993N8GRzjc3fQimtDJDHRtzU+59jl5MW7pijh6KqZOtdlSy4CoiWjhaLKU6XiRnU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KT+lRtoL; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT+lRtoL"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso16850506d6.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 16:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788995394; cv=none;
        d=google.com; s=arc-20260327;
        b=n3OO8GK9ANehxz/kVdyH7Gnqxa7/c1EVIcDH/Dz7QAPqiCuQvC5uEfuIcq2JxCu/CI
         FyS4JtlUNjHauBx4sj1NWOdrmD2PlUAtGGeyZpCxQhN2Jbb6lvYiDIdJsqbH0xUufTFV
         EuR6cDcn9kVdohSAImwmhH+oemmXMZelmXTABrxM/pS7I5vuGqOqhJb3PrpSkJa/upp7
         DW6x9DmWKqBh2Q/JpEw07Rh7ykRWLHTc1ecBgAdG+0tmBniUQKw8/CeIzVjw3BKxPmL7
         NCmQUBgmduXJED0TTVM23cxsZvBPIArYq5pXCX1yGFo+6YCj685Tdw4l1jZSV+odEDtf
         sKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZjZMi+BrlV8AXLFB5QByJEVcIGfPTEkRQ9POMJ1s+OU=;
        fh=eddMOc1m/XyLS4L1XNK2XdPgIxrdDxuuD9jTlKTL1qg=;
        b=lS+97ZSxUQGUnShoOCQGshjPg/zhS1snIMVhChYSW+8bODXLTMPqs9Bl+ezDEKlwi2
         xF+1ASRH8eNEXCdH9QnMjdjopIw7f9ZvXT4fhcuDjrm/8+afl8j7NLVW4vAjOpI+Eeyo
         YPCKUau3Mf5ua3fCy0jkEMlGByKDlW931FFvw4zfi+QKyq9mek8VXl4plvxlNwXOA1MG
         oHIdQzDDK62d1lTdLi7xU2EjZ8cepJWG1loWh/QhXEZZ7ENBGcVWpCunTRPVrvWVZSOX
         gpuFCbT/Wn8NgCUT9bOjrqUppE7wwa/NZ+m23kcJ8+jnqRYuLho9ZX/UA0gkV+WnsTUv
         e2Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788995394; x=1789600194; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjZMi+BrlV8AXLFB5QByJEVcIGfPTEkRQ9POMJ1s+OU=;
        b=KT+lRtoL/9NP/6rX0XVHgAL53SAmyKRVworgIsokRUt4U1U5HsW/PQ8lbrv/D0kwPt
         q3ay8LWXqiluxa9OX3Vaie+EJb9KpQ+nzMsU+ZtpbiUdeGM+8vE1HeBQ1zKSMU5GIpPG
         ZrtWNSpc/COu+G3hQ/BfQjXXzyUm0LCZSmyTA8t44MfbEqFE5gmdgTjyGZGLwlmPy/CP
         +DJCjH+uFGia2bM3zk81pb16ic6cSaShL8j+bJ6OnMM6bduhlJW8EWd/2jE1kNmfGLH4
         G6JhDidCTmLBtNimx0b3NJ/VrXkgwOmpWRRrR9Ut/6mL5MRVFF9PQErLjtzqvvagzb+U
         NPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995394; x=1789600194;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjZMi+BrlV8AXLFB5QByJEVcIGfPTEkRQ9POMJ1s+OU=;
        b=mqjSwglelPz+/OtwuUmKGJPRgfsbgrGnPWhQt1Pezz0cQZkXJ2v7N7Xz3WXNHSVtDb
         SHPMUoArvA18OwXfakU3ub+B476IQj/kQbnvY68j1tCXgnFu27HgCEqBiAz51WbczBlf
         nuQMz/E+OmzW/E0YmcwpZegIhWWR+iZEewtgg851P0RleVX3YGStG/DqFRsiQ+HXlHMw
         2X7Q25oIZDKKTtCBZVwbcpUNLAXjntXqW/KW+vnpKbV4jtCAmYtZkR+Ex81JG69QuGxu
         z3KY7Jqg7j9F4kbVemqEcwyYEQnO+rtAVq3QbTCofLFDNOEjjI/ildrWtKs688I6Xn0w
         l33Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdWf3xUabC4Ih8wioy+jRn/EBxTinduIhulso4ZOR0swMCFgghCf3XKIQyiT8wQZsLhU0=@vger.kernel.org
X-Gm-Message-State: AFuF++lFsNW01T+xzffXL7nfyJNTggrIYXR8taXJHGDPMuQvWcYRbnMP
	pXAzk3erE1EmR+TEmVB78uExsPKTh+9mTC22D8ffUaI8ysO2/7e6/fgR9d/yXDNoqCBZ2u2tjAj
	AA1fqV8fZVu5puSPZYd27I+csbCxky9Tep2D1PTc5ZnaEFkYw/xeGjwoSXJ8=
X-Gm-Gg: AYBFou1I0bdUPN0V1FX6fsPIE2QsX80s/eGfYU+REpl1VSXq7x4HugdfnkGtGtNyq07
	73UPOw1CQTCsyvcXVg+Kb0x2FXSBv7GHUVbXcoNF6n8prIyqfCALSSvYyEJibKDPNo81/tLdXr0
	+3NJy+9HGrVw9vwZkozwPU3rlsQN8nTxQBnDOw4yCsYK7/VbQRpAk//TeU1kbV1EZaFY84ViYF2
	5EeG3flIBckTsMpqtyUc2RCBLaPwDWCF1RKmgyTjBMUzSVu+MG8s4HOC4/wGQAgt6iScuvpbjCm
	yjNL9ip91Z28XbRRfkUnG8iKR+XPbHjmbfawBLMVkgIhftF3hITLJmsAP9WlGC5GdotebQvBhu7
	Ok+YF2W8F3NlkKGcb9PYw0OHSL+Fb1rkqFKJ5SAs9
X-Received: by 2002:a05:6214:19ed:b0:90e:9460:1c04 with SMTP id
 6a1803df08f44-9106b420805mr157144226d6.28.1788995393662; Wed, 09 Sep 2026
 16:09:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 16:09:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 16:09:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260904004342.3162959-3-seanjc@google.com>
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 16:09:52 -0700
X-Gm-Features: AcwNN1UqXVvxXkiDwIUg-skUc2h6LmZIfMxUe1jAdz2H8yG8B26L0C8Xq3BTGEc
Message-ID: <CAEvNRgHQJ4YdH-SQ0v5vmwgJHfuqkSArJk4=iQA-Hu28iaLSOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] KVM: Use goto to handle errors during memslot preparation
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Use a goto to unwind early memslot changes if preparing for a memslot
> operation fails.  This will allow moving the creation of guest_memfd
> bindings into kvm_set_memslot() without needing to copy+paste the unwind
> logic.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
