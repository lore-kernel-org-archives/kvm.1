Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210478;
	b=hlojSCeF4lbb3iTefcXFaHEjcCG6APFjfpQnEaqnCIp0yY2jj0FS1ZAzIxuw0KaUHT7r
	 atUj99iWJMXg+sXLrHF9fpRyYf7RwqYnORcWDqZIiyM2dLVctsFviRQqgRgQGQ5Y/a8v6
	 SZYwFFTkmtFdPaFkM1FHDE7ajjrRjntkvogQAM6+9l53/83hdL/eb20ARqPxvsh93s2dE
	 ysEIMlBk0cieMRyz6PIm65IIi+kgnOZj5gHKkpmuPt75v+QoWDKA4rMwN+2wGlBP/6Opo
	 mVu4aIEhdFL1k8WQX1Xlnuy1S7nIha4W5u+iYU1uB0vPSKuzMJQkqvhrVdnwXlLzI5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hYGrgEN624oSyPzumBDtLjqkMyYtHA8VinlvrqDbFmQ=;
	b=4jdQ8+FiC/XWYqebiYttU5IYvm3Thw5HY6LWEWKE1Td1VPWoKpVOT4Fd6JsYtEDsoxM8
	 V0yo29xBqYrthTX0IKMDWsVGh1sIPYlhUOFIzhttEsum1NzuY48qHSwJxnaoTfwVQ6q45
	 scpGlPRL+eAvlFZf3Cv8OVGeReVWBqUFRtqPrf+OYlnDQiV9VMJ0cLA7XkySeKt+k2xs5
	 JmrpOWZLOb8EnPXRm98POI8UJ1bZdWio0FBOEZyOEVRYnK2N67XS9kc630zBcSSg1Vafd
	 OmGLRJUZkHSoDZ2zVpwMlpJZOa5YicFwDnH/cwwa4squUfCM06uYEESQ1wNgYbLFfaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOBZRZvH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E54606A324
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E54606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOBZRZvH
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1382a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793210476; cv=none;
        d=google.com; s=arc-20260327;
        b=IVEFh7Triwb5kZJ8a+GHbn57AqGlHfLAK452nhq/X+zkxauuJuaol6Mdu5untUQyln
         +tWf/lFqwvTf/PegzmdqWN36qhDoORTP/DGw1i8eqnjeFgBKrmTLXMfyppJS2GsAWj1R
         Z5sdt5CgcZ3g5M2k32HUga4J1iezi56hQIMEuWu19GwAsPdo3yoNb57GzJL5RhoMYrlc
         u+4hX+KoLw2Tdf6jNI/PCPTpUJdB2vpMB5T2cheBaXM1pbHRCLyJZEvFXnvZRv2+rqxX
         bbXOzabHurynYUr/QgVTprMqRB3m2tBZApRYkew7/XdiBbT5Eu3f7BtqUWOx79zg8SjO
         XXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hYGrgEN624oSyPzumBDtLjqkMyYtHA8VinlvrqDbFmQ=;
        fh=Huljrc4RXzC4M4VmSqnv5OebPvSXO1leRZu6L25zsEQ=;
        b=U/pKsoIIi129p65C8GJvpcfd9T0GYHyh8Szdnmya9oFgtUGwe1B560hlIiRsnkX3sX
         z1P8oHu4/Yr7uAletF7tIoFLdhZ+/RWCJxNDqBEYTYPXVsz5pyxt59JNO6A2Hsojyng2
         zIxFFdIkRMRskrGBYsruEddkMZxuw6VotSXrjaiqk65jNgMWmpxI2fdeLWNsuye1JTXD
         f02SDnVJerKboFd4jDbtI8eBb0csdXKkt1VcBELGxlYLNv6X6Rbdy2PVWZXkzUHP6OWK
         VTOP0WOIOIyDbNDV3Wx37VkMDDIs9E3NeJCEoLj2FAo4nYAMFD0UEZ83VJG2XcJxfyon
         1LEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793210476; x=1793815276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hYGrgEN624oSyPzumBDtLjqkMyYtHA8VinlvrqDbFmQ=;
        b=QOBZRZvHIL09k9AL1uGushPvB9GQjg3DbSvjM6/Vn+qFJJVUiU5cbMqBWONhkV0CY8
         4eQpWDWCL8gMEMJcO4agzbotHKIpn4b4IDL8dewMenq/+MN2VLPxRHogIlMeK274XKHI
         mn0PIofziFPal5nOoXjrpSRU8f4haiD0lBSwMHPTbG3PBWON+C0gqTMyPP6WpRF6ygUq
         qyMP40M8XVjKQStAZI0dNE60Ar4RXRf5wfkZ04rRDh17xVE4hIzEoG6Hyd+yxXk27sWS
         qc0jClofoM5atPwFYwQmKFDqoB+i8aLeqwSaMy6FHOdvTNMOkePcI7rwBCEyta8jWAjt
         B25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210476; x=1793815276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYGrgEN624oSyPzumBDtLjqkMyYtHA8VinlvrqDbFmQ=;
        b=Pu5YlvSiLHLT1lOjZX9NNKk00NX1hz5NtO8kxFXUGAj8egAPZWlyQ2BDgHkv4uH3Nk
         e4tNHt9BcF8ojwwwRbyNOnhjAW5LklaW6JjVIKdlAouLfr2tan6NSUr440EpKX8Y5I0z
         DfUGK1+5NXFEeBru1B07ODDsmqsDR3C63LBmmcCZDOm5TS2sRTWTiLg1FSX8kTrDLzE6
         5Vfsl+9ALFqW2LL/4Mhs4iGxRgtMwrA2+viJg7+uLZkXsNz9Z59No911u59hJuLTulxJ
         ZxCUVgOR9AK1QR4umKjGct3jY24imePT/IEoQmyXdJP3qljmZ3JoKtfjklipX7/nnG8+
         HPZw==
X-Forwarded-Encrypted: i=1; AKwUvBzBVlTdndBotD/oB7R0jDTswGAUutij5Auvqk4rk0QjT8Bg/V/v0Gf0C2hpppeocRswedE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZLMwjD3VZ92jfLTtWAioPqiiV9kd+cA/5qO5tP4+aLk4VupbV
	b+V14/0d4gqcq6qMTzLwtrPe/1vFRIm7YzG9ljnUl9nrATIMsVmlG9CC1TMyqGqqad6sv+FSuZ2
	GczqaZ7G4fnLwMw7JsNHQjXBNgT+TLJmciGX9SQT7
X-Gm-Gg: AYBFou3QURihD6c6Pk7HBhd8iJeGznsxHEs55puFVcD+bmU9+2ydpQPDF0WhB7sdwB2
	+WArG9Myp49jaPnrxl+Agoytntg4Ul2y7xJ8OFQ+M9pMNkupEIOnLka7Bxo9+7vulExqK6e9Ohh
	K881BdORRH52z62h/ETGiQyZou5QWuvoy4GQ5wMjUp3qlICYbm3HvqAa8VTHm/oHQsg/5NuwPNU
	LluPodNBdUdUGiYXmPmCSwNOexZw5AxCSDIyaRXYFeeOoTbW/oGxecuoZJP4ZpkXbCIqBBplfxJ
	6OFmDXI6yxib4YqYuPBV+f+4oVuCwtfugP5NBKnaL603bJg0JtyyCi9+kvrrchYHawgR/B+NvMX
	5oFRAXMkdg1Wue9jf7C5DOREwEbLR4MyjJkvi
X-Received: by 2002:a05:6402:460e:20b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b4b10df53amr9804a12.4.1793210476079; Wed, 28 Oct 2026 11:01:16
 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-11-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-11-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 11:01:04 -0700
X-Gm-Features: AclHuK8yaY1Mr7Qag_ob8fNtdQv4hPRYzNkPHcADJjQZTbhiVJB96EDx-qQxwrA
Message-ID: <CALMp9eTyYFVmvqt6BRTSt4rc0XS8Oy4xGbagQjN_Maoiayd7Yw@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
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
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Now that KVM has switched to bitmap-based PMU capabilities,
> num_counters_{gp,fixed} can be removed from x86_pmu_capability.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
