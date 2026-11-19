Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127305;
	b=VCHdrCaZRu741/XSefOr51mfImLR7vFsSi06FtVXVO421B1i6NdF+hxc1bjIAgFEQEeL
	 ETfprlzOTyBmK/qvn33sR8mO0KqElNWSwRYHk3za/A13PbWCjPs/WISEqbfRDjhsFQQBo
	 96etIFB4cgj50eLLEpU5SIKNR62QpsK7cUzqGpS3C2KOiP0kCjitbpRU8GR8IMRqmozug
	 U4V8zPNIhohnJrN7X1Rp7s8RlWsYi8CzdJJyLcuL4ZPmiczyDCSNM1SE/6FQTHXTCu7O5
	 ohfM4VP+3ERPN7x+MheUmrsN6l0obAUuJfDmNJydp9rcSur5PeQOeOjrYAaKBnBujNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wZHBC5sw2L2iP+GCzxxs4jH8r0MidNJz0r8IrvTzFsY=;
	b=VAUpko4bV6mJALfZf0y9I7acYqwxD1ietCz/K/Hp3JzLox9EhLTyzHQslE91ujZVOSro
	 fZAWVtQ3Avl95zLw3FqwVrge2Q/QwY7TMKNHKLyx9vIu/ykElbVG39XjYZ7w0M1+k6BaU
	 JSL9xsQLBo2qD4mxjJynOhqWqppMtJucK7tRk7GNpFZ7zFsmWE4aeufc3aeaaz1aDPBrP
	 WjcN5RpIdrdNzZFCBUx2miQ8hVlqaSRHVkV54eyKYZm3FPxqIsVzPFtLRlkfwoEppGtST
	 m+jFEOyKc9uPKejVoHC3oEFmMozdJdp7ieFAViOE8EDMFiAgdWCPf2BXcTeE08rmOGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fzggma1u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90643606A32A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 22:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90643606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fzggma1u
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so4456a12.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127304; cv=none;
        d=google.com; s=arc-20260327;
        b=bOfT612iyCqEhyLvFBhSBd3nkXLAUddDpercm/ZWh6y/d1NKhzoo1G/SCOeX2cUtwK
         UAfUgPSxzyU78X4NnmchXylTWv/Qt2AB2Vvoe97GuGHrkg8eHPifjXLFxzZmDPrEeZvP
         5F/+TPpKgW6JeT8lQGuHlFhrNpKS7eZigAzwegv2HIXR/V9bR0MerqxAcd25EVBKZdJB
         Qbt2fGljXcoyYwPZyRL7QInWGPAkXnfeegJdF4rJWM0mYScZN+2vBRD4C/xdkPX1lv7W
         QzRSNe/6vhFUzl551BsaIXHV27pm3rIb/9ac2TEzVACb78aWCL964Z46skkyx4fTjsXy
         RDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZHBC5sw2L2iP+GCzxxs4jH8r0MidNJz0r8IrvTzFsY=;
        fh=t74nbHoeZOFZyMQNokdc+9pui1NnrGraqwYE4m/srqI=;
        b=SH6LeXkX/U+VKMnB7XPwjLyOJjOeVbJlOO5srkY3zvQm7zPWu5BdnI6Z0d/eqXBw+v
         Pr/II1OWax1wpS5DWwp8QtbzEOqtrPosbsTQI8/pA/W0DBMu9TEY1TEmeXj4gbMUbRsO
         9y0yW6pP1nlJhAsFNKDMPFP1nhHXkqQVQIPRNbTa7P4GtlsKiDXfO5WvOyiEoeNhwYh9
         8SV71DuPwNTEfQG0dllIUKX4dsWtuNZjd3yOzwr2prONCUGyNQkmsv1yJmW6Y6yCHWjW
         DEYlXNKrfZ/qSlDDXR9730T5mFtbVrJOU9hV3CgXPQ9ZKwOP4tuCJePdzG1XGiNMIOgz
         ixeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795127304; x=1795732104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZHBC5sw2L2iP+GCzxxs4jH8r0MidNJz0r8IrvTzFsY=;
        b=fzggma1uemGRme4kyuyCukHGhSuIQpKb65EtRv2khvp27LxFOLBa0YNATq6vqefWu8
         uTCQzDrGT45wY2IvpeuGSEXg0b3vtfI+zrAWNF/DPGyLCMdTp5gUM1oN/kDRKx2MXJb5
         n6TcqVRr1+9szQrf9LRVE4MPxkYVFq1ZBXz7+lqfB382wQuD7/fDV/YHYmT74uQoV52D
         +88JRZ75hslg6PXg1nsnmi/fzurXS5K6a7XtzmVj8jXOo7Fs6BLMt3QHTWNLa4E26PHy
         nO4pvUYtYKdBof17oNEX/VzcP9g49wvmU+GBlsbHkihCUxRxegX288PpACcII247av5V
         vLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127304; x=1795732104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZHBC5sw2L2iP+GCzxxs4jH8r0MidNJz0r8IrvTzFsY=;
        b=Yl+h9+5ZkhpLNbqJeC18Ktqtp+VnJz+HtQXSnEdfef88Vh/8yrkf33dOYrUFz4T6nZ
         B91s3wBY31At+6yhhYDoLkOMQqLS//BxoSAoQP2TkLwO+zuhfipRZc9QmFJc1Om3NUC7
         9VBJxLlF9+w9KmopEF5Q2tCzHGKVXrZH/A7MKBhos6E3bW+PkBvtL9riUZ8zlBRiJN+T
         daBlC3utVCGbp8U7NA0NjP/FfCXEzx/OFYxoNWagUCEuuZwKFdS606Dg+OlRXCxiGY8K
         C81Hx7yKjToYAJ3ziRYw4vNKFgjTAW4Msw8NjVYdSuFiFI+Imfwj0Z+juW2g6UMNPsus
         Md5w==
X-Forwarded-Encrypted: i=1; AL+hErGPE9pH4kvLXWz74jY3pL3smOvzmDAx6SqKo9xBn0llEoFWPyI60K+OpCti/4RGROCc64M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uOLPWRwC5XBQiOAH6fGdmb7qiIZAGkFO/Vsbm6C92ri+l1vbg
	Vcf0elcli9MypiS4AqOkFYGd4e2I6z2BUfHkqap7qIfadcFx1CbJkGTsk+NM1DvfzwgOMAwogg+
	fJTovz1B1T0vEs62Ab4Dx9/e8qWDOIsShfVYEjJTp
X-Gm-Gg: AZFdTZcQgMynlpl7p87VhztMPZ1k2/0D7+9jRYiILlcfd6hFdD6Fx9dm7xWfvNrUahR
	jtLTWlfT4KLOvRXuZkVaUHvhXo6O7cFEm0+zOhYsnJ/Eftrmo52dPYuQ/eCH4R1am8EIlkOQc6X
	hxi1FzNZklCr4jeX2xrowCPPkEPbrrG5q3ViJY4wf2aYDdjTF7FCunDNJPtykRzeFIKuQyKX80Z
	89eFkmiPrQLawHoCyVyQjtkyjpkx14fNCYy6xPXSrnTeeRjHCbowgyn/UnJGEk5LFq4lDddgARk
	zD2Q8is05fmYoi9XL7GugCztUZRXiwQ2b7qijTi86K2EKoQGkq9Khw61om76TzKRHHRuvQBYC9C
	8iZzMbqDnIlBhY6ZzuZGFZJbSdzwV85n6ZGShqmdn9HCfjF4YBY2dlM5WMgKm/y+7DUTJ65Fd9+
	YMe2hqahKv0qME8AAXTOqmTb4vU3Re7oFyYjAoir2dE8sDRu8DEKuVKg==
X-Received: by 2002:a05:6402:a594:10b0:6b8:7775:5154 with SMTP id
 4fb4d7f45d1cf-6ba3eff9382mr14227a12.9.1795127303537; Thu, 19 Nov 2026
 14:28:23 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-10-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-10-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 14:28:10 -0800
X-Gm-Features: Aa3M54pUftGEPQEyxlJJ-Rl2y8uq22UmR-tja4ORd1HgqfGqUEa4uN8aY6PFB6Q
Message-ID: <CALMp9eRjFq50nJK2EWF0Z6+6OT+MhpY-y8u9_Eb6XhaYB_yJJg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] KVM: nSVM: Propagate LBRv2 state across nested transitions
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:08=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Copy the LBRv2 state on nested VMRUN and #VMEXIT just like the legacy
> LBR state. If L1 enables V_LBR for L2, L2 has its own LBRv2 state in
> vmcb12. If L1 does not enable V_LBR, L2 uses the LBRv2 state of L1.
>
> Add svm_copy_lbrs_v2() macro to copy this state. Keep it separate from
> svm_copy_lbrs(), because the LBR stack is 256 bytes and KVM copies it
> only when LBRv2 is supported.

IIUC, LBRv2 state is *not* handled the same way as LBR state on VMRUN/#VMEX=
IT.

Per the APM vol. 2 (rev. 3.45), section 15.23.1:

  VMRUN saves the host state and restores the guest state and #VMEXIT saves
  the guest state and restores the host state of the DebugExtnCtl
  MSR. VMRUN only restores the guest state and #VMEXIT only saves the guest
  state of the LastBranchStackFromIp, LastBranchStackToIp and
  LastBranchStackSelect MSRs.

This is asymmetric. The only LBRv2 host MSR that is saved/restored is
DebugExtnCtl.
