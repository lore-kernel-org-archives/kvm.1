Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17D366078;
	Thu,  5 Mar 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734772; cv=none; b=nxoMywkqECt8TregZpgmujQMMPbMrg/rs2uVfTvS2R3lxS0rfl1hoGd83fNVu7f2wCDt5TXg+8dKtdxtBWcxDTvWb2z+vEbnpWMo/3XWE4BbxhCSpjpusklnd80/cUZV/Fum6px2/WZM04EjLHY1fYYt3+V/kNyF66hHuxTqIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734772; c=relaxed/simple;
	bh=4Tc/KAY0GBDAe9mAqjvKIM20YswWBDTUfMNyQxN460A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uNjeTbGxyqCYxTZb+S1Wf5sqftCsVEnH2jV9LPADx+Ivb2gSsSRqfzDmRXD2qBWNeCNXPOh/fPIlz56XFqKD3fshbk2MQmNa3QhQeNYrln+s7bvlzN+xmbLIoxT7Emx2AccucvdswYWq/NCh/R6JUXcvsfP/ONygVRrWZq0G41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Hb8f9C6V; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hb8f9C6V"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 625Hl8vd3560389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Mar 2026 09:47:08 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 625Hl8vd3560389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1772732829;
	bh=CjTCnaKYWUbRJ1sgAvN35vorMdc+lmIlICQF5lNVu68=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Hb8f9C6VdtZ+JuFRr/E/XJ8g+T8xD8ogv5ZAC7Cx0ZwoAyvSJRwBzTgW6FT/GdoU8
	 1LZFVQ6gEpD/jiGjfVJyzgrb09epiEGLNA/wQh/flrircnIxp1NQaUrHW9mp4LTOic
	 kKVgx8lyZMg5fjR+tJHgCqEh6ZwnxNQSbBdaMeVsfEpJB6aPjiJwiN/lL3NUuOX/BC
	 ql5Ki54WqYIrbRh6JEPJXdVhQvFsT12iDI70pNhceppAk2pnUNAALo6cPaDbWLn99z
	 qy6/ryv7dxsz6Mi0DF/Fr6/Goj/QE5pBEZJF0zyF7+uFIxdfiIaRBs51eTC+L083kn
	 w/1zy1Wq6z0SQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v9 15/22] KVM: x86: Mark CR4.FRED as not reserved
From: Xin Li <xin@zytor.com>
In-Reply-To: <B07CDF1A-1FD2-4EC5-BEB3-3D906A880153@zytor.com>
Date: Thu, 5 Mar 2026 09:46:58 -0800
Cc: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
        hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <237876C4-5253-4059-ABBC-3FB4EB5C2ABC@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <20251026201911.505204-16-xin@zytor.com> <aR1xNLrhqEWu+rmE@intel.com>
 <aajVJlU2Zg4Djqqz@google.com>
 <263F364B-D516-40B3-B065-A5369BFB1A7F@zytor.com>
 <aamisPkG1JZ2UDdQ@google.com>
 <B07CDF1A-1FD2-4EC5-BEB3-3D906A880153@zytor.com>
To: Sean Christopherson <seanjc@google.com>
X-Mailer: Apple Mail (2.3864.400.21)



> On Mar 5, 2026, at 9:09=E2=80=AFAM, Xin Li <xin@zytor.com> wrote:
>=20
>=20
>>> I planned to send out these new kvm unit tests (not just FRED tests) =
after
>>> KVM FRED patch series gets merged.
>>=20
>> Definitely send them before.  Even if no one outside of Intel can run =
them (I
>> forget when FRED hardware is coming), people like me can at least see =
what you're
>> testing, which makes it more likely that we'll spot bugs.  E.g. in =
this case, the
>> lack of negative tests for CR4.FRED is a big red flag.
>=20
> No excuse, sadly mk_cr_64() completely escaped my notice.

BTW, mk_cr_64() looks a bad name to me, it=E2=80=99s more like =
mk_cr_32().

>=20
> And I didn=E2=80=99t even think about adding a CR4 test for FRED.
>=20
> And as you expected, the happy path doesn=E2=80=99t expose it at all.
>=20
>=20
>=20

