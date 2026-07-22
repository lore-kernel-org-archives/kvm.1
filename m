Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4A30D402
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757120; cv=pass; b=TEJ7LA3ElUD3xKxB7/N/nI0bMFZCV4WH0OxQHKUjOYZL0GniPL0I+ZpVCFdF72GqQ7DGCqGf+PPLXdr2jnGxTxsdHK/nvrFlmBGcuy+kZ3OGwOVYfXvDfDzsQCqde/bj7U/H0jJwuIvtDzhdNLy1R/BJWzjKYfOgUxE2UfjKUIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757120; c=relaxed/simple;
	bh=NKp6qthR25lw2wP4nRCDYKfxmAg68xyizXu9csd9zNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqr9ALGF28ilhLTHg5GF/N9mZ+83Li1/eg/rsFDa8K0ZYaxUU6Mt0pMWUY0AkwXtJUvYx9n4Ip0rl+NTjzA70kWCrDvFtPA1A30QEEx1ECZEdU1bI1pHKmD7CtO1hoTyjBvFzvpKBa+ZnML8qOOILeV9lj5zyqd/RYHNLfDRiR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G72sSjPU; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G72sSjPU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so712a12.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784757117; cv=none;
        d=google.com; s=arc-20260327;
        b=kzeH1cEmNT9qwVGk+aoUfU8k+DanE9qI3Len0nbRcZHcVylgjjDDfiZhG4yEsosKU9
         v1SFwGRQDRBalcc0ZTebVWu/XOPisZvBJ9QB9b8iscfJgClevmwQAr6+jU+z+PU1SuTT
         wCNkmNQMAc0w5RfCTRMFR7ZkiV/pRKCN/g8RrjJRrcRGijreIcFpjMl1yQvkiDqzAFbJ
         GTg/j1OgeORkjbRoVoFcQX4feut2sVE1AWruo2esUdOED8hgQLKHTH16Kkl46KMuIJ9b
         pItSMkrcFpH+Z8v8voyweSmAbPz5vmZjG4y7Rt2qv1J66S1eZh69FeJEd/NkCJJzTyP5
         wA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYaVDwWuGPsEj2qeZBp6ESCvdbq5qbXm9q2GPaQNGDs=;
        fh=YPPvphbLAxbSyxe2xCayRo6GFT5Fy+cZeuf9eFz5nA4=;
        b=K1d1hqz0+Y43l4w2I1d1sq9QIPBf5/ZkzQsx6BbsmL3fgmEI0HFUlNNdNGBNvj8H7X
         BLb9NamO+d9EZU+9xmyRjRlxtbgspYFm61cbi4S1eUAwcE6L5Dttcp0IG+2/nACzBu3Q
         SjRLYLzXCxThqWLf2xe0G9pPQ8ZQkzLRGNkyMOaC4YTCzSg3RvH1ug9kY3il6MxOshEK
         8ny+ndS+q3VmT2A9b/sKJfIJe6HaEmeXwq+6HQsIY2Yd17SOKxMcH5q1rtDS2nolxPNR
         XeP2On6S2Hd8FdYzmfddYtZG04gRktizqNWPfrJQ70MfYY6D1fhkv5y6GKHKtF14q2/0
         x0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784757117; x=1785361917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYaVDwWuGPsEj2qeZBp6ESCvdbq5qbXm9q2GPaQNGDs=;
        b=G72sSjPUG1LLNFqQmHtog24TlWP6pAaNBYGon5lXH3BEMmxMJudLhzA/4MrW0sWDTv
         7gfwbt10r8M6hNV+nQAYrQ/Q5ygHoCncJpuBpyaQX1OVPSjlKHewNza++c1y0d/qsuut
         usgwRti7eNdbzunmD+pAkWTTe1TWOOPqoavW9A5PR8ZZ6WGSJcdvyPuBhbRoEudKl+D+
         uBjkTh5StLz7ZQDCdkUupvQtZH3ZsnbgmE5s1a7VSlG4BNv0CvtmPPYr032GceSS+FqN
         6l5U4Uyr2j2c2ssR4MeXjVQkbfUkBhGIktiyCedD/KpS3MlocSmBfegcn+S0JxwJaoKr
         Uarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757117; x=1785361917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYaVDwWuGPsEj2qeZBp6ESCvdbq5qbXm9q2GPaQNGDs=;
        b=a/xZQHtGF/8a6kiT1ODODfhrQQA8qM2ui3Hk3LyRU34L5E+ujtuMSHdvc7UOcgvx3M
         QZTWjy5kIsU4TzJvlPVLJmbybx2pbCywhnHDmVVAWDc/R96uEuq89dCelZoz+XJ+TdT1
         nbk+vxiV6du0oO4ONA6+5wIdBmpYVWD59ZI9TfLb02p7x46da0NKNH7L2MZQBw0K3dcL
         HVxu8sSUlscLrHlbRycpkJhJ0TwhdJ0aUG8R6OA5AK/sO41wZHyEaUnbOGe+R4wbv1bQ
         41w0D7ddHYiKeV6vR1JbuVnqO54UNxxdUVhrPTTeUj0c3APjQ/Vj+/FMTZBFAi69lKrJ
         XT5g==
X-Forwarded-Encrypted: i=1; AHgh+RrTZcRiPhisCmoleL7g4kQbSJi0R6UAygUtxkLRrPBh2qz8PmCR7nVY6Bib5rXtVbmQRVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnzgRkOVBl9Jeq7RQ0P4b2J4AUogLiOuGyww8WhhDCXdFZjMh
	7NzUTAJEKKhpbw8IU64sSY9wvDTvrZzAZqsxqGy/AoMIazVC4OojfYIs7QgMh24nA18CCE+JSsD
	0B35AkyW8i6D3D+ZvC2KUD/i/zjaIZKnheyTHIaB+
X-Gm-Gg: AR+sD138yBoAYyi6oP7jFUrAt59eeQqz1iaVH9SmKw+ZkO7nBlXUM1jos64b6oU3T8M
	R96GiZ9QKs2fEvGwCVBHJnc+D22Q4JAaDBIeadwyvFeQTek7ononBac6AAgywZAr90IfTdHXmQO
	PvTWfB2WxCPFKj/aump+r4wXsDtmfn3ZKT7DgCd7Dk5N9hVbcMu/37IcM9PkAizZhSt4K5oKNqL
	K/+j0L+Gsqqbs7oRFpp9U0Eq2R+HhzeA49e9Pc7mpUa6NoQvxPV4DwiGIaGDA==
X-Received: by 2002:a05:6402:22f4:b0:697:df76:63f8 with SMTP id
 4fb4d7f45d1cf-69f6c60e86amr6151a12.3.1784757116373; Wed, 22 Jul 2026 14:51:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-2-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-2-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 14:51:44 -0700
X-Gm-Features: AUfX_mzILLh46VncVVk2gxJ7QYlYUgNM4QqYadnjizYw1qX29tb-mfYBtG3_qoY
Message-ID: <CALMp9eQpn_MbGJU1dsyq-uVeFNZdHkjEPJ88uVzR0jao=phkZA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] KVM: x86/pmu: Do not map fixed counters >= 3 to
 generic perf events
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Only fixed counters 0..2 have matching generic cross-platform
> hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
> Therefore, perf_get_hw_event_config() is only applicable to these
> counters.
>
> KVM does not intend to emulate fixed counters >=3D 3 on legacy
> (non-mediated) vPMU, while for mediated vPMU, KVM does not care what
> the fixed counter event mappings are.  Therefore, return 0 for their
> eventsel.
>
> The two BUILD_BUG_ON() checks are no longer needed, so drop them along
> with __always_inline.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
