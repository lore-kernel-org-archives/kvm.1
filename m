Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66755149C6F
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837125; cv=none; b=dRBodMY0uaciDQ4H6cLHoLANg4IO/6kj2bWPhdYeNW/DsKmuuqmaVXh6GR/yNb0xqXn1I42liv/A6PmoBhUzrS7vR5+Cvaf2Y40StrtCKACOua61eoocPRPgn5pAwPW4KifirpJdA9aS7tKgxGPoQN4mCiXZqUExk0/Gq9xqp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837125; c=relaxed/simple;
	bh=RZlmmzm0R4exhEkMoRSbWb7EXNwLa4WbzlBeZQUuCJ8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ENi6cIo6QS89yA9T8IYUJ+0F0H3pc6m7bGM5OWSks/DH7HUp4k/sPCj09zytH//ZWCU2FEEDs2s6nUgO/tJkzrqwg0dXiGoVInoEcMLlCWx2q4z/dfd65pjNRhnboQ7pobUNaXA62WUI/Fuv7Rdurnbohx+b5zTY6bZjxrmohrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M8IUIwFI; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M8IUIwFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3g62bbeu2rc6zar6om4ucwal2u.protonmail; t=1772837112; x=1773096312;
	bh=RZlmmzm0R4exhEkMoRSbWb7EXNwLa4WbzlBeZQUuCJ8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M8IUIwFIrpS+QA7cWmCMf81u2hu+Ok3jOSjjU3JV9vlwymH3n0w8Q0qhrpWZVw4JB
	 Hhsg17pS+GZ464nEqZQBC8l2gDuVRI5TjzjQyDuCaRapP0HNOkqZ+n2nn4CkDC7dIi
	 nwyAYK49fiM4irGZV0qF6x/2/VSuK1vfs7FVG+fs0v8QuOGBRIZVKVXAn0mtzWnL1N
	 ImH1R3Nof6P5jGhdqhhWd4uELMq6YkweYxn885e9akgr5ieAe0C4LiC3wDMzsdjolM
	 GNb7hhVYLG43zWcpjH9XoN2laK2p8Cl52GROJmr3sUrFJuHt7ZO0idnHpLJt9hJHbK
	 nrWxpgjsWghPw==
Date: Fri, 06 Mar 2026 22:45:09 +0000
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
From: brianharveyos <brianharveyos@proton.me>
Subject: Bug 219161 - VM with virtio-net doesn't receive large UDP packets
Message-ID: <16uwcutC6tZWCoJJULgKBLI8zwKXyTeRpcUEYK4AUazFevxHg4FTd5lttS14E8oZrpLbWmARGhgpQTaUoZIEF5Ho_wepzZXWpgXBqHWTFTA=@proton.me>
Feedback-ID: 154631810:user:proton
X-Pm-Message-ID: a70a229e7efcf181f3c57e9ddd2f9c39784b87e9
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apologies if this isn't the correct way to do this but I noticed this bug (=
219161) in bugzilla with no assignee. Is this something anyone is welcome t=
o submit a patch for or is it being actively worked on by someone else?

Thank you,
Brian Harvey
