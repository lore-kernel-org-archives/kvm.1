Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794525434;
	b=ezWW43DkE86rNEXM1n9irWKn3UFXvUHQgtLpMnnZmsCgrYTHhu1bnjbRSb9tmpUGppeR
	 yn9d+NvCzyMF8aBxu53UffjH0YXGAndefaVhwBWv4YT86vFvlSyBEeIP7bB6nlAFLBOjA
	 3ZNBgA4H67VynmU4giXV0QcX9M2dOs/iORsY3oiUsC6eEAFszubnpab1e2sRCbsBJUXtF
	 Fbkn3Ft/hKUerNw10S8gsCIfZMjPYgNzb9dGh54cx8ofmeDMUTOixiV5lu4ZcwZ6T+DXU
	 TloQjc4toIlIiKoo5VP+irIqTCViRORVTXHy+YU9n7Ct3aV501zUzgvRKI0Q/E5Tl7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HYer4KNej6OjpPHSLUJVrnFp2nfCzxQPfaR3MfS134g=;
	b=GmPkhPtp5VhZHjwI8qVUpRYFPfwwucPe90xFOj+RDlwRPIvJrTIrragFHekZklJ9GuVg
	 EV2gjPsSGc9m7Euju7EJ47lGLsyNJMuW08mArYWcj2kOR758iNeVaxxb1e71k2V1fytVz
	 5KMK22vqWvjoz/P6Xxer2Z8yjvEXaehbo1IJb3MFkr/gBiaMCpUKvHmVnen97ELEV/mU6
	 rvHuq3g5kpE1RGpWP+KJTrog7PAX2GAtNITYZ0dbf33gzXJg16Qtlyup52zTd+6kQ3ElF
	 Um829QPqt96LTIMIMpVJMiZmnWuv78PZf2k6hGDqRrfNoxgCIVqR4ZW1Yo1/vIN9gpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=efvAcmws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76E606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 23:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB76E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=efvAcmws
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso823a12.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 15:17:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794525432; cv=none;
        d=google.com; s=arc-20260327;
        b=PwhJ6Ijhx1WZA/vTeGU8PFqTN53F2z6ruMRQWvT7Nfsik8fPwBDp09Dw4sCk5Lrhn5
         r2zkZl2A6FPRkPySgpeokduhLyPgPJWKDpuOrfR8NMmtXBuD1RwTofhKz6tJqlIG7h0n
         Typ9btWfwNMvv0GsRtQU4oPNtBALZ4qzSo6UrwjGYA/FY6Ov0yNduf9lieGFN7/Zvbti
         r/TguJrxLkoQ3HMhkkMgf8G95wrc9+0eCxKkCKvyx6YiznWIpPZQy/UWRdLibrJ94RGI
         A1u8uxxoaCBgQAhgyxU9QdUllKF5OhQIA2YbEH66VzdyfenW8aj+GUiYReH45aw4rrny
         yTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYer4KNej6OjpPHSLUJVrnFp2nfCzxQPfaR3MfS134g=;
        fh=nCtEYoJCci/SFN6LvDfsaSDLfn0Ea3Kt8T79M/uMEF8=;
        b=szD72VgmlDzcm97YPW2Yn7POlAOllOQi13cFcbGnF3/MZx7jBMH5V5TExIV6xNiUwf
         axVBC2pbT/gC57EPGxF1Y7G6qfjlQklUoxdOq1zOcEpPyOxBeYPK0SiFQh0l5OebAkiV
         SmUgGK6zZqIePz0S0aK8X6pyvQRz/Ng2zsWL8Pq8hPBXCjUo/7Hj01Y6lYwjwiJBhy2k
         oNdOcpWScGsyTEnB4Ah/nRvzE72kved2I2+4Bm7/PjZ61MwgL4fqias03sWZq4b9Y3xo
         XggefIM9vXhkmZhR/R4wKXPNqRrz81StUP7p6FQuL3BTpwZUIm2rWoF15Yd5KKttgsoa
         t5FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794525432; x=1795130232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HYer4KNej6OjpPHSLUJVrnFp2nfCzxQPfaR3MfS134g=;
        b=efvAcmws6mhucmMwtkeQlmU3MLbS53DQ04Wr3YnRmRD6wIfE+rw7KL5dIx2p6qIDXS
         SO5kDbGGsUeLXiZu6Cf5P4opNv48rExtOY4DuVQ9NgPgg3hV2ZdQm/7v3fvs0AWzl54b
         7SU61YK8w346V3DYAVXp5xQU/RB5kwS/LTyatJvbVBNsZA5k1bqATk9Auujv3dB1918l
         6CuZoA9+yOIqFaP+/6+lsSq9AQrmIN2+ALBeTetWFLgmt06uyZpauy7tmcxwVJilOa9x
         MlphQNAPsVZ/17fIAnI0lxNc6jyFJU5BRXU6iIoOGf0TbBLXpbfwsj7BUfrJWnnmzsvX
         P7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525432; x=1795130232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYer4KNej6OjpPHSLUJVrnFp2nfCzxQPfaR3MfS134g=;
        b=1P8wj1TU5Qn+8pzOcLacpqQKMdxbq5sPHlqI0JkU514nRQVw8i43rsedXLn+5YyLFM
         WtM9c1avcROmxb0wZleXb21pHF2NBedwsuZZMZbp+yr7nqjGuImdqY6W42n1XUJEqQRN
         Jkd+zyOoLxUaYfiNN0aEPtNbMPnk8+jWPhp3O2EjDPHGNoGlNLkj3A+6fPpxXDN7qBOW
         MXEQgxKSE+syRI/2Gt8cOY1WfeRSFFOCltN1/1Jtsr8gt4GXoLqhL2zrhcx51tTX73ur
         G8+i5brcSdF/UV5w+9jZWnoTWt4cJ+yhmBe/Jc7t+dzWnKrlxTLNBE5gMiLcyzjcVAx4
         blHA==
X-Forwarded-Encrypted: i=1; AL+hErHeVZpoy3ju+9Rb68wWdKvyynopVgWPsLSe/JOwEGUq0kFGlD8uqFJRs11pQxPulMj+OmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ckBh9HkuAl/AKPAkf2pSt+ndX83ZjzG8leXbpyvvg7FpzgHiT
	933YXbgnreq80E4Yj2rC/5erSu4rFjNHTTLQh2aCA/jgqvQaKss+Yqb9eRK6LEjbsNbDxQIPY0V
	A6V9enz4GJpKqDBDBWAMQ4fKFNGK4kxKvx2XZWdOR
X-Gm-Gg: AYBFou2+ELezTnlL2K5WzoUUwO5ipgYL/Mb3EObiT9238O13yf0DWW/XY1OHDh/zqmQ
	ErZ1qLuVLS24s3l3jmMpr2j/pLA6a/5LQuWVVg5eJt5hGm8Kc33uf3AoxWv8vzWP4YmX5FdYrHZ
	Aef3BVPW4sJgInXZ76dD0sqpcdQgZRqAF1TpQESL9vewQChcy/iuRnJ6DsmOmNRqAEORL90Dx4J
	v1onw6CCobGNN5Ubnn0owiciSu9NGnTF0ywDfBYZfhn+vWya/t2BO/7a+NW+8y9AlC3oSIcguLo
	jh92hC/OJWa8pBQTEmYMukRhWx8wX/fFA/5Jwfcl5J2Zsujo9Jb5zR5Gv2UqC05IQdYzzpe9pyY
	lIcqvb4fCimlfysl2aPXJ/7vnwEcVpgLnx6JvfddhQh2nVFFYPj7DWRDIwxiZtFrJjoGyFYwW
X-Received: by 2002:a05:6402:1246:b0:6b6:eccd:ce77 with SMTP id
 4fb4d7f45d1cf-6b7c82b1e66mr16244a12.9.1794525431853; Thu, 12 Nov 2026
 15:17:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112212628.265262-1-jmattson@google.com> <CAO9r8zMkKXRT0N18haYG+=jyO6FvL7VE84-=n9kpm7vnARH5UA@mail.gmail.com>
In-Reply-To: <CAO9r8zMkKXRT0N18haYG+=jyO6FvL7VE84-=n9kpm7vnARH5UA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 12 Nov 2026 15:16:59 -0800
X-Gm-Features: AclHuK9ZK_GSTisZi4uuT65jTyFZEXSzRQMsAQ_YhJ2__8gddMdEVlL8gP2vTNw
Message-ID: <CALMp9eRmJ8BpWHrveE=nTD6vF9OrB=OiwNA15_4Df-=kUzmMnA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state()
 on guest SHSTK
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Nov 12, 2026 at 1:26=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > Like nested_vmcb02_prepare_save() and nested_svm_vmexit_update_vmcb12()=
,
> > svm_copy_vmrun_state() should gate copying s_cet, isst_addr, and ssp on
> > guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) (i.e. the feature is adverti=
sed
> > to the guest). Instead, copying is gated on
> > kvm_cpu_cap_has(X86_FEATURE_SHSTK) (i.e. the host supports shadow stack=
s).
>
> This is a bit confusing, nested_vmcb02_prepare_save() and
> nested_svm_vmexit_update_vmcb12() are about vmcb12 <-> vmcb02, so L2's
> state, while svm_copy_vmrun_state() is for L1's state. I think the
> patch is correct, but the examples are confusing.
>
> Perhaps a better example would be __kvm_set_msr() and __kvm_get_msr()?

Or, perhaps I should just drop the examples?
